object FrmConfigNetWork: TFrmConfigNetWork
  Left = 0
  Height = 412
  Top = 0
  Width = 450
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Preferences'
  ClientHeight = 412
  ClientWidth = 450
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  FormStyle = fsStayOnTop
  KeyPreview = True
  OnCreate = FormCreate
  Position = poScreenCenter
  LCLVersion = '2.0.6.0'
  object GroupBox1: TGroupBox
    Left = 10
    Height = 261
    Top = 10
    Width = 430
    Align = alTop
    Caption = ' Proxy '
    ClientHeight = 261
    ClientWidth = 430
    TabOrder = 0
    object ProxyTypeLbl: TLabel
      Left = 78
      Height = 13
      Top = 27
      Width = 28
      Alignment = taRightJustify
      Caption = 'Type'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ProxyServerLbl: TLabel
      Left = 68
      Height = 13
      Top = 56
      Width = 38
      Alignment = taRightJustify
      Caption = 'Server'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ProxyPortLbl: TLabel
      Left = 325
      Height = 13
      Top = 57
      Width = 24
      Alignment = taRightJustify
      Anchors = [akRight]
      Caption = 'Port'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ProxyUsernameLbl: TLabel
      Left = 48
      Height = 13
      Top = 83
      Width = 58
      Alignment = taRightJustify
      Caption = 'Username'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ProxyPasswordLbl: TLabel
      Left = 52
      Height = 13
      Top = 110
      Width = 54
      Alignment = taRightJustify
      Caption = 'Password'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ProxyScriptURLLbl: TLabel
      Left = 15
      Height = 13
      Top = 135
      Width = 58
      Caption = 'Script URL'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ProxyByPassListLbl: TLabel
      Left = 15
      Height = 27
      Top = 176
      Width = 402
      Anchors = [akTop, akLeft, akRight]
      AutoSize = False
      Caption = 'ByPass list'#13#10'qwerwqreqwrwqer'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = tlBottom
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object MaxConnectionsPerProxyLbl: TLabel
      Left = 143
      Height = 13
      Top = 235
      Width = 185
      Alignment = taRightJustify
      Anchors = [akRight]
      Caption = 'Maximum connections per proxy'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object PrtocolLbl: TLabel
      Left = 295
      Height = 13
      Top = 28
      Width = 54
      Alignment = taRightJustify
      Anchors = [akRight]
      Caption = 'Protocolo'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object ProxyTypeCbx: TComboBox
      Left = 108
      Height = 21
      Top = 24
      Width = 170
      Anchors = [akTop, akLeft, akRight]
      ItemHeight = 0
      ItemIndex = 0
      Items.Strings = (
        'Direct'
        'Autodetect'
        'System'
        'Fixed servers'
        'PAC script'
      )
      Style = csDropDownList
      TabOrder = 0
      Text = 'Direct'
    end
    object ProxyServerEdt: TEdit
      Left = 108
      Height = 21
      Top = 53
      Width = 205
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 2
    end
    object ProxyPortEdt: TEdit
      Left = 351
      Height = 21
      Top = 53
      Width = 68
      Anchors = [akTop]
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 3
      Text = '80'
    end
    object ProxyUsernameEdt: TEdit
      Left = 108
      Height = 21
      Top = 80
      Width = 311
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 4
    end
    object ProxyPasswordEdt: TEdit
      Left = 108
      Height = 21
      Top = 107
      Width = 311
      Anchors = [akTop, akLeft, akRight]
      EchoMode = emPassword
      PasswordChar = '*'
      TabOrder = 5
    end
    object ProxyScriptURLEdt: TEdit
      Left = 15
      Height = 21
      Top = 148
      Width = 404
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 6
    end
    object ProxyByPassListEdt: TEdit
      Left = 15
      Height = 21
      Top = 205
      Width = 404
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 7
    end
    object ProxySchemeCb: TComboBox
      Left = 351
      Height = 21
      Top = 24
      Width = 68
      Anchors = [akTop]
      ItemHeight = 0
      ItemIndex = 0
      Items.Strings = (
        'HTTP'
        'SOCKS4'
        'SOCKS5'
      )
      Style = csDropDownList
      TabOrder = 1
      Text = 'HTTP'
    end
    object MaxConnectionsPerProxyEdt: TSpinEdit
      Left = 331
      Height = 22
      Top = 232
      Width = 88
      Anchors = [akRight, akBottom]
      MaxValue = 99
      MinValue = 7
      TabOrder = 8
      Value = 32
    end
  end
  object GroupBox2: TGroupBox
    Left = 10
    Height = 84
    Top = 274
    Width = 430
    Align = alTop
    Caption = ' Custom header '
    ClientHeight = 84
    ClientWidth = 430
    TabOrder = 1
    object HeaderNameLbl: TLabel
      Left = 101
      Height = 13
      Top = 26
      Width = 32
      Alignment = taRightJustify
      Caption = 'Name'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object HeaderValueLbl: TLabel
      Left = 102
      Height = 13
      Top = 53
      Width = 31
      Alignment = taRightJustify
      Caption = 'Value'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object HeaderNameEdt: TEdit
      Left = 134
      Height = 21
      Top = 23
      Width = 285
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 0
    end
    object HeaderValueEdt: TEdit
      Left = 134
      Height = 21
      Top = 50
      Width = 285
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 10
    Height = 25
    Top = 377
    Width = 430
    Align = alBottom
    BevelOuter = bvNone
    ClientHeight = 25
    ClientWidth = 430
    TabOrder = 2
    object BntOk: TButton
      Left = 30
      Height = 25
      Top = 0
      Width = 120
      Align = alLeft
      Caption = 'Ok'
      OnClick = BntOkClick
      TabOrder = 0
    end
    object BntCancel: TButton
      Left = 280
      Height = 25
      Top = 0
      Width = 120
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
