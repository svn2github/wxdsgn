object ViewToDoForm: TViewToDoForm
  Left = 192
  Top = 107
  Width = 565
  Height = 230
  BorderStyle = bsSizeToolWin
  Caption = 'To-Do list'
  Color = clBtnFace
  Constraints.MinHeight = 136
  Constraints.MinWidth = 394
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lv: TListView
    Left = 0
    Top = 0
    Width = 557
    Height = 155
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        Width = 24
      end
      item
        Caption = 'Priority'
      end
      item
        Caption = 'Description'
        Width = 224
      end
      item
        Caption = 'Filename'
        Width = 150
      end
      item
        Caption = 'User'
        Width = 90
      end>
    ReadOnly = True
    RowSelect = True
    SortType = stBoth
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lvColumnClick
    OnCompare = lvCompare
    OnCustomDrawItem = lvCustomDrawItem
    OnCustomDrawSubItem = lvCustomDrawSubItem
    OnDblClick = lvDblClick
    OnMouseDown = lvMouseDown
  end
  object controls: TPanel
    Left = 0
    Top = 155
    Width = 557
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      557
      41)
    object lblFilter: TLabel
      Left = 6
      Top = 5
      Width = 25
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Filter:'
    end
    object chkNoDone: TCheckBox
      Left = 6
      Top = 25
      Width = 289
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Don'#39't show items marked as done'
      TabOrder = 0
      OnClick = chkNoDoneClick
    end
    object cmbFilter: TComboBox
      Left = 37
      Top = 2
      Width = 245
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akBottom]
      ItemHeight = 13
      TabOrder = 1
      OnChange = cmbFilterChange
      Items.Strings = (
        'All files (in project and not)'
        'Open files only (in project and not)'
        'All project files'
        'Open project files only'
        'Non-project open files'
        'Current file only')
    end
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
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
    Left = 529
  end
end
