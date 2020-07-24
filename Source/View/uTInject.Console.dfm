object FrmConsole: TFrmConsole
  Left = 268
  Height = 519
  Top = 330
  Width = 885
  Caption = 'TInject component'
  ClientHeight = 519
  ClientWidth = 885
  Color = clBtnFace
  DoubleBuffered = True
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ParentDoubleBuffered = False
  Position = poOwnerFormCenter
  ShowHint = True
  LCLVersion = '2.0.6.0'
  object Pnl_Top: TPanel
    Left = 0
    Height = 22
    Top = 497
    Width = 885
    Align = alBottom
    BorderStyle = bsSingle
    ClientHeight = 18
    ClientWidth = 881
    Color = clWhite
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object Lbl_Caption: TLabel
      Left = 1
      Height = 16
      Top = 1
      Width = 797
      Align = alClient
      Alignment = taCenter
      Caption = 'TInject component'
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Layout = tlCenter
      ParentColor = False
      ParentFont = False
    end
    object lbl_Versao: TLabel
      Left = 798
      Height = 16
      Top = 1
      Width = 82
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'V. 1.0.0.0'
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Layout = tlCenter
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      WordWrap = True
      OnMouseEnter = lbl_VersaoMouseEnter
    end
    object Img_LogoInject: TImage
      Left = 29
      Height = 18
      Top = 1
      Width = 22
      Center = True
      OnMouseEnter = lbl_VersaoMouseEnter
      Proportional = True
      Transparent = True
    end
    object Img_Brasil: TImage
      Left = 1
      Height = 18
      Top = 1
      Width = 25
      Center = True
      OnMouseEnter = lbl_VersaoMouseEnter
      Proportional = True
      Transparent = True
    end
  end
  object Pnl_Geral: TPanel
    Left = 0
    Height = 497
    Top = 0
    Width = 885
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Pnl_Geral'
    ClientHeight = 497
    ClientWidth = 885
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 1
    object CEFWindowParent1: TCEFWindowParent
      Left = 0
      Height = 121
      Top = 0
      Width = 885
      Align = alTop
      TabOrder = 0
    end
  end
  object Chromium1: TChromium
    OnBeforeContextMenu = Chromium1BeforeContextMenu
    OnTitleChange = Chromium1TitleChange
    OnConsoleMessage = Chromium1ConsoleMessage
    OnBeforeDownload = Chromium1BeforeDownload
    OnDownloadUpdated = Chromium1DownloadUpdated
    OnBeforePopup = Chromium1BeforePopup
    OnAfterCreated = Chromium1AfterCreated
    OnBeforeClose = Chromium1BeforeClose
    OnClose = Chromium1Close
    OnOpenUrlFromTab = Chromium1OpenUrlFromTab
    left = 56
    top = 136
  end
  object CEFSentinel1: TCEFSentinel
    OnClose = CEFSentinel1Close
    left = 48
    top = 72
  end
end
