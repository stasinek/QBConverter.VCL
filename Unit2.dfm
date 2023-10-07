object Form2: TForm2
  Left = 413
  Top = 140
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Skala...'
  ClientHeight = 52
  ClientWidth = 228
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 228
    Height = 52
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 135
      Top = 8
      Width = 41
      Height = 37
      Anchors = [akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDD2DDDDDDDDDDDDDDD7DDDDDDDDDDDDDD222DDD
        DDDDDDDDDD777DDDDDDDDDDDD22222DDDDDDDDDDD77777DDDDDDDDDD2222222D
        DDDDDDDD7777777DDDDDDDD222222222DDDDDDD777777777DDDDDD2222222222
        2DDDDD77777777777DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 180
      Top = 8
      Width = 40
      Height = 37
      Anchors = [akTop, akRight, akBottom]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333993333333993333388333333388333339993333399
        9333338883333388833333399933399933333338883338883333333399939993
        3333333388838883333333333999993333333333388888333333333333999333
        3333333333888333333333333999993333333333388888333333333399939993
        3333333388838883333333399933399933333338883338883333339993333399
        9333338883333388833333993333333993333388333333388333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = SpeedButton2Click
    end
    object Label1: TLabel
      Left = 104
      Top = 16
      Width = 23
      Height = 23
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Pitch = fpFixed
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CSpinEdit1: TCSpinEdit
      Left = 8
      Top = 8
      Width = 89
      Height = 35
      TabStop = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DragCursor = crDefault
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Increment = 5
      MaxValue = 1000
      MinValue = 1
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      TabOrder = 0
      Value = 100
      OnDblClick = SpeedButton1Click
    end
  end
end
