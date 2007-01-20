object FilesReloadFrm: TFilesReloadFrm
  Left = 192
  Top = 123
  BorderStyle = bsDialog
  Caption = 'Select Files to Reload'
  ClientHeight = 277
  ClientWidth = 345
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 8
    Top = 8
    Width = 296
    Height = 26
    Caption = 
      'The files listed below have been modified or deleted outside of ' +
      'wxDev-C++.'
    WordWrap = True
  end
  object btnOK: TButton
    Left = 182
    Top = 247
    Width = 75
    Height = 23
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 262
    Top = 247
    Width = 75
    Height = 23
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 1
  end
  object ctlFiles: TPageControl
    Left = 8
    Top = 43
    Width = 330
    Height = 200
    ActivePage = tabModified
    TabIndex = 0
    TabOrder = 2
    object tabModified: TTabSheet
      Caption = 'Modified Files'
      object lblModified: TLabel
        Left = 0
        Top = 0
        Width = 322
        Height = 26
        Align = alTop
        Caption = 
          'Check the files which you want wxDev-C++ to discard all unsaved ' +
          'changes and reload from disk.'
        WordWrap = True
      end
      object lbModified: TCheckListBox
        Left = 0
        Top = 49
        Width = 322
        Height = 123
        OnClickCheck = lbModifiedClickCheck
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
      end
      object pnlModifiedSelectAll: TPanel
        Left = 0
        Top = 26
        Width = 322
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          322
          23)
        object chkSelectAll: TCheckBox
          Left = 0
          Top = 5
          Width = 322
          Height = 17
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Select All Files'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = chkSelectAllClick
        end
      end
    end
    object tabDeleted: TTabSheet
      Caption = 'Deleted Files'
      ImageIndex = 1
      object lbDeleted: TListBox
        Left = 0
        Top = 0
        Width = 322
        Height = 172
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = False
    Active = False
    Left = 8
    Top = 247
  end
end
