object VMF: TVMF
  Left = 215
  Top = 128
  ActiveControl = sdate
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'VMaker'
  ClientHeight = 481
  ClientWidth = 673
  Color = 13619151
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label2: TLabel
    Left = 10
    Top = 158
    Width = 111
    Height = 16
    Caption = #1044#1086#1082#1091#1084#1077#1085#1090' '#1060#1055#1055#1069':'
  end
  object Bevel1: TBevel
    Left = -10
    Top = 128
    Width = 681
    Height = 22
    Shape = bsBottomLine
  end
  object Panel2: TPanel
    Left = 10
    Top = 89
    Width = 237
    Height = 50
    BorderStyle = bsSingle
    Caption = 'Panel2'
    TabOrder = 10
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 673
    Height = 80
    Align = alTop
    Color = clSilver
    TabOrder = 6
    object Label1: TLabel
      Left = 20
      Top = 10
      Width = 93
      Height = 16
      Caption = #1059#1082#1072#1078#1080#1090#1077' '#1076#1072#1090#1091':'
    end
    object Bevel2: TBevel
      Left = 325
      Top = 39
      Width = 188
      Height = 11
      Shape = bsTopLine
    end
    object Button4: TButton
      Left = 256
      Top = 30
      Width = 92
      Height = 30
      Cursor = crHandPoint
      Caption = #1055#1088#1086#1096#1083#1099#1081
      TabOrder = 0
      OnClick = Button4Click
    end
    object Button6: TButton
      Left = 354
      Top = 30
      Width = 93
      Height = 30
      Caption = #1053#1072#1095#1072#1083#1086
      TabOrder = 1
      OnClick = Button6Click
    end
  end
  object sdate: TDateTimePicker
    Left = 20
    Top = 30
    Width = 227
    Height = 24
    Date = 39091.519460833300000000
    Format = '[ddd.] dd.MM.yyyy'
    Time = 39091.519460833300000000
    Color = 8454143
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnChange = sdateChange
  end
  object Button1: TButton
    Left = 20
    Top = 98
    Width = 218
    Height = 31
    Cursor = crHandPoint
    Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1040#1057#1050#1059#1069' '#1060#1055#1055#1069
    TabOrder = 1
    OnClick = Button1Click
  end
  object pc: TPageControl
    Left = 0
    Top = 230
    Width = 673
    Height = 232
    ActivePage = TabSheet3
    Align = alBottom
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #1048#1089#1093#1086#1076#1085#1099#1077
      object FPP: TListBox
        Left = 0
        Top = 0
        Width = 665
        Height = 201
        Align = alClient
        Color = 16777088
        ItemHeight = 16
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1055#1086#1095#1072#1089#1086#1074#1099#1077
      ImageIndex = 1
      object hourd: TListBox
        Left = 0
        Top = 0
        Width = 665
        Height = 201
        Align = alClient
        Color = 16777088
        ItemHeight = 16
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 2
      object Label3: TLabel
        Left = 10
        Top = 10
        Width = 189
        Height = 16
        Caption = #1050#1086#1076' '#1087#1088#1077#1076#1087#1088#1080#1103#1090#1080#1103'-'#1079#1072#1082#1072#1079#1095#1080#1082#1072':'
      end
      object Label4: TLabel
        Left = 10
        Top = 79
        Width = 174
        Height = 16
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1079#1072#1082#1072#1079#1095#1080#1082#1072':'
      end
      object Edit1: TEdit
        Left = 10
        Top = 30
        Width = 287
        Height = 21
        Color = 14663679
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 10
        Top = 98
        Width = 287
        Height = 21
        Color = 14663679
        TabOrder = 1
      end
      object dayauto: TCheckBox
        Left = 10
        Top = 143
        Width = 287
        Height = 21
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1077#1088#1077#1081#1090#1080' '#1085#1072' '#1076#1077#1085#1100' '#1074#1087#1077#1088#1077#1076
        TabOrder = 2
      end
    end
  end
  object newd: TEdit
    Left = 10
    Top = 177
    Width = 464
    Height = 21
    Color = 8454016
    ReadOnly = True
    TabOrder = 3
  end
  object Button3: TButton
    Left = 571
    Top = 177
    Width = 92
    Height = 31
    Cursor = crHandPoint
    Caption = #1042#1099#1073#1088#1072#1090#1100
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button2: TButton
    Left = 453
    Top = 30
    Width = 92
    Height = 30
    Cursor = crHandPoint
    Caption = #1057#1083#1077#1076#1091#1102#1097#1080#1081
    TabOrder = 5
    OnClick = Button2Click
  end
  object log: TListBox
    Left = 256
    Top = 89
    Width = 405
    Height = 50
    Color = 15987699
    ItemHeight = 16
    TabOrder = 7
    OnDblClick = logClick
  end
  object Button5: TButton
    Left = 482
    Top = 177
    Width = 83
    Height = 31
    Cursor = crHandPoint
    Caption = #1053#1086#1074#1099#1081
    TabOrder = 8
    OnClick = Button5Click
  end
  object sb: TStatusBar
    Left = 0
    Top = 462
    Width = 673
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object od: TOpenDialog
    Left = 456
    Top = 192
  end
  object MainMenu1: TMainMenu
    Left = 488
    Top = 192
    object N1: TMenuItem
      Caption = #1059#1090#1080#1083#1080#1090#1072
      object N4: TMenuItem
        Caption = #1042#1099#1081#1090#1080
        OnClick = N4Click
      end
    end
    object N2: TMenuItem
      Caption = '?'
      object N3: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = N3Click
      end
    end
  end
end
