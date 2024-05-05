unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, ShellAPI,
  Winapi.TlHelp32;

type
  Tfrm_main = class(TForm)
    Close: TBitBtn;
    bit_run: TBitBtn;
    cmd_input: TEdit;
    lbl_command: TLabel;
    inj_cmd: TEdit;
    btn_inject: TBitBtn;
    edit_pid: TEdit;
    lbl_PID: TLabel;
    lbl_inj_cmd: TLabel;
    lbl1: TLabel;
    Label1: TLabel;
    btn_Override: TBitBtn;
    lbl_memoryride: TLabel;
    btn_crash: TBitBtn;
    lbl_Crasher: TLabel;
    crash_pid: TEdit;
    Lbl_crash: TLabel;
    mem_edit: TEdit;
    lbl_men: TLabel;
    mem_value: TEdit;
    lbl_value: TLabel;
    procedure bit_runClick(Sender: TObject);
    procedure btn_injectClick(Sender: TObject);
    procedure btn_crashClick(Sender: TObject);
    procedure btn_OverrideClick(Sender: TObject);

  private
    function ExecuteCmdAndGetOutput(const ACommand: string): string;

  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation

{$R *.dfm}

type
  TCrashThreadProc = function(Parameter: Pointer): DWORD; stdcall;

function AnsiToWideString(const S: AnsiString): WideString;
begin
  Result := WideString(S);
end;

function InjectCommandIntoProcess(PID: DWORD;
  const Command: AnsiString): Boolean;
var
  hProcess: THandle;
  RemoteBuffer: Pointer;
  BytesWritten: SIZE_T;
  ThreadID: DWORD;
begin
  Result := False;

  hProcess := OpenProcess(PROCESS_CREATE_THREAD or PROCESS_QUERY_INFORMATION or
    PROCESS_VM_OPERATION or PROCESS_VM_WRITE or PROCESS_VM_READ, False, PID);
  if hProcess = 0 then
  begin
    OutputDebugString('Failed to open target process');
    Exit;
  end;

  try
    RemoteBuffer := VirtualAllocEx(hProcess, nil, Length(Command),
      MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE);
    if RemoteBuffer = nil then
    begin
      OutputDebugString('Failed to allocate memory in target process');
      Exit;
    end;

    if not WriteProcessMemory(hProcess, RemoteBuffer, PAnsiChar(Command),
      Length(Command), BytesWritten) then
    begin
      OutputDebugString('Failed to write command into target process memory');
      Exit;
    end;

    if CreateRemoteThread(hProcess, nil, 0, @LoadLibraryA, RemoteBuffer, 0,
      ThreadID) = 0 then
    begin
      OutputDebugString('Failed to create remote thread in target process');
      Exit;
    end;

    Result := True;
  finally
    CloseHandle(hProcess);
  end;
end;

procedure Tfrm_main.btn_crashClick(Sender: TObject);
begin
  ShowMessage(ExecuteCmdAndGetOutput('crasher.exe ' + crash_pid.Text));
end;

function OverrideMemory(AddressHex: string; NewValue: Integer): Boolean;
var
  Address: Pointer;
  OldProtect: DWORD;
begin
  Address := Pointer(StrToIntDef('$' + AddressHex, 0));

  if Address = nil then
  begin
    Result := False;
    Exit;
  end;

  if VirtualProtect(Address, SizeOf(NewValue), PAGE_READWRITE, @OldProtect) then
  begin
    Integer(Address^) := NewValue;

    VirtualProtect(Address, SizeOf(NewValue), OldProtect, @OldProtect);

    Result := True;
  end
  else
    Result := False;
end;

procedure Tfrm_main.btn_injectClick(Sender: TObject);
var
  PID: Integer;
  Command: AnsiString;
begin
  PID := strtoint(edit_pid.Text);
  Command := inj_cmd.Text;

  if InjectCommandIntoProcess(PID, Command) then
    ShowMessage('Command injected successfully')
  else
    ShowMessage('Failed to inject command');
end;

procedure Tfrm_main.btn_OverrideClick(Sender: TObject);
var
  AddressHex: string;
  NewValue: Integer;
  Address: Pointer;
begin
  AddressHex := mem_edit.Text;

  if not TryStrToInt('$' + AddressHex, NewValue) then
  begin
    ShowMessage('Invalid memory address');
    Exit;
  end;

  Address := Pointer(NewValue);

  if Address = nil then
  begin
    ShowMessage('Failed to override memory');
    Exit;
  end;
  NewValue := StrToIntDef(mem_value.Text, 0);

  if OverrideMemory(AddressHex, NewValue) then
    ShowMessage('Memory overridden successfully')
  else
    ShowMessage('Failed to override memory');
end;

function Tfrm_main.ExecuteCmdAndGetOutput(const ACommand: string): string;
const
  BUFFER_SIZE = 4096;
var
  SecurityAttributes: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  BytesRead: DWORD;
  Buffer: array [0 .. BUFFER_SIZE - 1] of AnsiChar;
  CmdLine: WideString;
begin
  Result := '';
  FillChar(SecurityAttributes, SizeOf(TSecurityAttributes), 0);
  SecurityAttributes.nLength := SizeOf(TSecurityAttributes);
  SecurityAttributes.bInheritHandle := True;

  if not CreatePipe(ReadPipe, WritePipe, @SecurityAttributes, 0) then
    Exit;

  try
    FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
    StartupInfo.cb := SizeOf(TStartupInfo);
    StartupInfo.hStdInput := ReadPipe;
    StartupInfo.hStdOutput := WritePipe;
    StartupInfo.hStdError := WritePipe;
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    StartupInfo.wShowWindow := SW_HIDE;

    CmdLine := AnsiToWideString('cmd.exe /C ' + AnsiString(ACommand));

    if CreateProcess(nil, PWideChar(CmdLine), nil, nil, True, 0, nil, nil,
      StartupInfo, ProcessInfo) then
    begin
      CloseHandle(WritePipe);
      repeat
        BytesRead := 0;
        ReadFile(ReadPipe, Buffer, BUFFER_SIZE, BytesRead, nil);
        if BytesRead > 0 then
        begin
          Buffer[BytesRead] := #0;
          Result := Result + AnsiString(Buffer);
        end;
      until BytesRead = 0;
      CloseHandle(ReadPipe);
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
    end;
  finally
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
  end;
end;

procedure Tfrm_main.bit_runClick(Sender: TObject);
begin
  ShowMessage(ExecuteCmdAndGetOutput(cmd_input.Text));
end;

end.
