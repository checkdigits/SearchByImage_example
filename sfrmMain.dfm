object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Search by Image'
  ClientHeight = 647
  ClientWidth = 1067
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  StyleName = 'Sky'
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 647
    Align = alLeft
    Caption = 'Image Analysis Client'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      377
      647)
    object imgSource: TImage
      Left = 15
      Top = 160
      Width = 346
      Height = 346
      Center = True
      Proportional = True
    end
    object btnSearch: TButton
      Left = 286
      Top = 610
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Search'
      Enabled = False
      TabOrder = 0
      OnClick = btnSearchClick
    end
    object edAPIURL: TLabeledEdit
      Left = 15
      Top = 28
      Width = 346
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = 'API URL'
      TabOrder = 1
      Text = 'https://api.bing.microsoft.com/v7.0/images/visualsearch/'
    end
    object edSubKey: TLabeledEdit
      Left = 15
      Top = 72
      Width = 346
      Height = 21
      EditLabel.Width = 130
      EditLabel.Height = 13
      EditLabel.Caption = 'Ocp-Apim-Subscription-Key'
      TabOrder = 2
    end
    object edImgPath: TLabeledEdit
      Left = 15
      Top = 117
      Width = 265
      Height = 21
      EditLabel.Width = 55
      EditLabel.Height = 13
      EditLabel.Caption = 'Image Path'
      TabOrder = 3
    end
    object btnBrowse: TButton
      Left = 286
      Top = 115
      Width = 75
      Height = 25
      Caption = '&Browse'
      TabOrder = 4
      OnClick = btnBrowseClick
    end
  end
  object memResponse: TMemo
    Left = 377
    Top = 0
    Width = 489
    Height = 647
    Align = alClient
    BorderStyle = bsNone
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object scrlbxImages: TScrollBox
    Left = 866
    Top = 0
    Width = 201
    Height = 647
    Align = alRight
    TabOrder = 2
  end
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    ContentType = 'application/json'
    Params = <>
    Left = 920
    Top = 48
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Method = rmPOST
    Params = <>
    Response = RESTResponse
    Left = 920
    Top = 112
  end
  object RESTResponse: TRESTResponse
    ContentType = 'text/plain'
    Left = 920
    Top = 176
  end
  object dlgOpenImage: TOpenDialog
    Filter = 
      'All (*.svg;*.gif;*.jpg;*.jpeg;*.png;*.bmp;*.ico;*.emf;*.wmf;*.ti' +
      'f;*.tiff)|*.svg;*.gif;*.jpg;*.jpeg;*.png;*.bmp;*.ico;*.emf;*.wmf' +
      ';*.tif;*.tiff|Scalable Vector Graphics (FNC) (*.svg)|*.svg|GIF I' +
      'mage (*.gif)|*.gif|JPEG Image File (*.jpg)|*.jpg|JPEG Image File' +
      ' (*.jpeg)|*.jpeg|Portable Network Graphics (*.png)|*.png|Bitmaps' +
      ' (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.' +
      'emf|Metafiles (*.wmf)|*.wmf|TIFF Images (*.tif)|*.tif|TIFF Image' +
      's (*.tiff)|*.tiff'
    Left = 648
    Top = 208
  end
  object http: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 808
    Top = 480
  end
end
