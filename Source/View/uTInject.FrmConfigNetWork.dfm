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
  object GroupBox1: TGroupBox
    Left = 0
    Height = 280
    Top = 0
    Width = 450
    Align = alTop
    Caption = ' Proxy '
    ClientHeight = 262
    ClientWidth = 446
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
      Left = 341
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
      Width = 418
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
      Left = 152
      Height = 13
      Top = 238
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
      Left = 311
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
      Width = 186
      Anchors = [akTop, akLeft, akRight]
      ItemHeight = 13
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
      Width = 221
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 2
    end
    object ProxyPortEdt: TEdit
      Left = 365
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
      Width = 327
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 4
    end
    object ProxyPasswordEdt: TEdit
      Left = 108
      Height = 21
      Top = 107
      Width = 327
      Anchors = [akTop, akLeft, akRight]
      EchoMode = emPassword
      PasswordChar = '*'
      TabOrder = 5
    end
    object ProxyScriptURLEdt: TEdit
      Left = 15
      Height = 21
      Top = 148
      Width = 420
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 6
    end
    object ProxyByPassListEdt: TEdit
      Left = 15
      Height = 21
      Top = 205
      Width = 420
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 7
    end
    object ProxySchemeCb: TComboBox
      Left = 365
      Height = 21
      Top = 24
      Width = 68
      Anchors = [akTop]
      ItemHeight = 13
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
      Left = 347
      Height = 21
      Top = 234
      Width = 88
      Anchors = [akRight, akBottom]
      MaxValue = 99
      MinValue = 7
      TabOrder = 8
      Value = 32
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Height = 99
    Top = 280
    Width = 450
    Align = alTop
    Caption = ' Custom header '
    ClientHeight = 81
    ClientWidth = 446
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
      Width = 301
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 0
    end
    object HeaderValueEdt: TEdit
      Left = 134
      Height = 21
      Top = 50
      Width = 301
      Anchors = [akTop, akLeft, akRight]
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Height = 25
    Top = 387
    Width = 450
    Align = alBottom
    BevelOuter = bvNone
    ClientHeight = 25
    ClientWidth = 450
    TabOrder = 2
    object BntOk: TButton
      Left = 0
      Height = 25
      Top = 0
      Width = 120
      Align = alLeft
      Caption = 'Ok'
      OnClick = BntOkClick
      TabOrder = 0
    end
    object BntCancel: TButton
      Left = 330
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
