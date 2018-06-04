object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Resource Builder (FONT AWESOME)'
  ClientHeight = 851
  ClientWidth = 1185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 851
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      225
      851)
    object lblIcons: TLabel
      Left = 3
      Top = 6
      Width = 26
      Height = 13
      Caption = 'Icons'
    end
    object lvIcons: TListBox
      AlignWithMargins = True
      Left = 3
      Top = 22
      Width = 219
      Height = 826
      Style = lbOwnerDrawFixed
      Anchors = [akLeft, akTop, akRight, akBottom]
      DoubleBuffered = False
      ExtendedSelect = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'FontAwesome'
      Font.Style = []
      Font.Quality = fqAntialiased
      ItemHeight = 24
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      TabWidth = 10
      OnDblClick = lvIconsDblClick
      OnDrawItem = lvIconsDrawItem
      OnKeyPress = lvIconsKeyPress
    end
  end
  object pnlRight: TPanel
    Left = 225
    Top = 0
    Width = 960
    Height = 851
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      960
      851)
    object lblSample: TLabel
      Left = 15
      Top = 311
      Width = 506
      Height = 402
      Caption = #61674'  '#61669
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -59
      Font.Name = 'FontAwesome'
      Font.Style = []
      Font.Quality = fqAntialiased
      ParentFont = False
    end
    object Label3: TLabel
      Left = 666
      Top = 6
      Width = 46
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Point Size'
    end
    object Label4: TLabel
      Left = 218
      Top = 238
      Width = 53
      Height = 13
      Caption = 'Characters'
    end
    object Label5: TLabel
      Left = 6
      Top = 238
      Width = 75
      Height = 13
      Caption = 'Resource Name'
    end
    object Label1: TLabel
      Left = 794
      Top = 6
      Width = 31
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Colour'
    end
    object lblSizing: TLabel
      Left = 6
      Top = 284
      Width = 37
      Height = 13
      Caption = 'lblSizing'
    end
    object lblFileName: TLabel
      Left = 446
      Top = 259
      Width = 53
      Height = 13
      Caption = 'lblFileName'
    end
    object edtChars: TEdit
      Left = 218
      Top = 254
      Width = 81
      Height = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'FontAwesome'
      Font.Style = []
      Font.Quality = fqAntialiased
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = #61674'  '#61669
      OnChange = edtCharsChange
    end
    object btnGlypherise: TButton
      Left = 667
      Top = 131
      Width = 105
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Update Button->'
      TabOrder = 1
      OnClick = btnGlypheriseClick
    end
    object edtSize: TSpinEdit
      Left = 723
      Top = 3
      Width = 65
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 32
      OnChange = edtSizeChange
    end
    object edtResName: TEdit
      Left = 6
      Top = 254
      Width = 201
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'EDTRESNAME'
      OnChange = edtResNameChange
    end
    object chkAutoSpace: TCheckBox
      Left = 218
      Top = 283
      Width = 97
      Height = 17
      Caption = 'AutoSpaced'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object btnTest: TBitBtn
      Left = 776
      Top = 131
      Width = 176
      Height = 104
      Anchors = [akTop, akRight]
      Caption = 'Test Button'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
      Spacing = 8
      TabOrder = 5
    end
    object chkEnabled: TCheckBox
      Left = 667
      Top = 162
      Width = 74
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Enabled'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = chkEnabledClick
    end
    object ColorListBox1: TColorListBox
      Left = 831
      Top = 3
      Width = 121
      Height = 99
      Anchors = [akTop, akRight]
      TabOrder = 7
      OnClick = ColorListBox1Click
    end
    object lvResources: TListView
      Left = 6
      Top = 6
      Width = 528
      Height = 229
      Anchors = [akLeft, akTop, akRight]
      Columns = <
        item
          Caption = 'Resource Name'
          Width = 275
        end
        item
          Caption = 'Character List'
          Width = 210
        end>
      HideSelection = False
      RowSelect = True
      TabOrder = 8
      ViewStyle = vsReport
      OnDblClick = lvResourcesDblClick
    end
    object btnDelete: TButton
      Left = 540
      Top = 6
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Delete'
      TabOrder = 9
      OnClick = btnDeleteClick
    end
    object bntPNG: TButton
      Left = 540
      Top = 37
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Make .PNG'
      TabOrder = 10
      OnClick = bntPNGClick
    end
    object btnSaveResources: TButton
      Left = 540
      Top = 109
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save File'
      TabOrder = 11
      OnClick = btnSaveResourcesClick
    end
    object btnMakeRC: TButton
      Left = 540
      Top = 140
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Make .RC && .BMP'
      TabOrder = 12
      OnClick = btnMakeRCClick
    end
    object btnMakeRes: TButton
      Left = 540
      Top = 171
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Make .RES'
      TabOrder = 13
      OnClick = btnMakeResClick
    end
    object btnAddToList: TButton
      Left = 305
      Top = 254
      Width = 135
      Height = 25
      Caption = 'Update / Add To List'
      TabOrder = 14
      OnClick = btnAddToListClick
    end
    object btnBitmap: TButton
      Left = 540
      Top = 68
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Make .BMP'
      TabOrder = 15
      OnClick = btnBitmapClick
    end
  end
end
