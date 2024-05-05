object frm_main: Tfrm_main
  Left = 639
  Top = 354
  Caption = 'Command Feeder V1'
  ClientHeight = 353
  ClientWidth = 699
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object lbl_command: TLabel
    Left = 369
    Top = 93
    Width = 58
    Height = 15
    Caption = 'command:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_PID: TLabel
    Left = 39
    Top = 123
    Width = 21
    Height = 15
    Caption = 'PID:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_inj_cmd: TLabel
    Left = 23
    Top = 93
    Width = 51
    Height = 15
    Caption = 'commad:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 432
    Top = 51
    Width = 109
    Height = 33
    Caption = 'Terminal'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 80
    Top = 51
    Width = 95
    Height = 33
    Caption = 'Injector'
    Font.Charset = ANSI_CHARSET
    Font.Color = clCrimson
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object lbl_memoryride: TLabel
    Left = 80
    Top = 182
    Width = 152
    Height = 33
    Caption = 'Memory edit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clLime
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object lbl_Crasher: TLabel
    Left = 432
    Top = 186
    Width = 96
    Height = 33
    Caption = 'Crasher'
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clFuchsia
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentColor = False
    ParentFont = False
  end
  object Lbl_crash: TLabel
    Left = 402
    Top = 236
    Width = 24
    Height = 15
    Caption = 'PID: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_men: TLabel
    Left = 29
    Top = 236
    Width = 45
    Height = 15
    Caption = 'Address:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_value: TLabel
    Left = 40
    Top = 265
    Width = 31
    Height = 15
    Caption = 'Value:'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Close: TBitBtn
    Left = 311
    Top = 316
    Width = 75
    Height = 25
    Caption = '&Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Kind = bkClose
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
  end
  object bit_run: TBitBtn
    Left = 592
    Top = 89
    Width = 75
    Height = 25
    Caption = '&Run'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = bit_runClick
  end
  object cmd_input: TEdit
    Left = 432
    Top = 90
    Width = 154
    Height = 23
    TabOrder = 2
  end
  object inj_cmd: TEdit
    Left = 80
    Top = 90
    Width = 154
    Height = 23
    TabOrder = 3
  end
  object btn_inject: TBitBtn
    Left = 240
    Top = 89
    Width = 75
    Height = 25
    Caption = '&Inject'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCrimson
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btn_injectClick
  end
  object edit_pid: TEdit
    Left = 80
    Top = 120
    Width = 154
    Height = 23
    TabOrder = 5
  end
  object btn_Override: TBitBtn
    Left = 240
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Override'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btn_OverrideClick
  end
  object btn_crash: TBitBtn
    Left = 592
    Top = 232
    Width = 75
    Height = 25
    Caption = '&Crash'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clFuchsia
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = btn_crashClick
  end
  object crash_pid: TEdit
    Left = 432
    Top = 233
    Width = 154
    Height = 23
    TabOrder = 8
  end
  object mem_edit: TEdit
    Left = 80
    Top = 233
    Width = 154
    Height = 23
    TabOrder = 9
  end
  object mem_value: TEdit
    Left = 80
    Top = 262
    Width = 154
    Height = 23
    TabOrder = 10
  end
end
