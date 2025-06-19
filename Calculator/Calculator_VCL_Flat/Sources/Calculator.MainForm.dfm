object CalculatorForm: TCalculatorForm
  Left = 0
  Top = 0
  ClientHeight = 463
  ClientWidth = 312
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 312
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object TitleLabel: TLabel
      AlignWithMargins = True
      Left = 44
      Top = 3
      Width = 140
      Height = 35
      Align = alLeft
      AutoSize = False
      Caption = 'Calculator'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object MenuButton: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 33
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      ImageAlignment = iaCenter
      ImageIndex = 0
      ImageName = 'menu'
      Images = VirtualImageList
      TabOrder = 0
    end
  end
  object DisplayPanel: TPanel
    Left = 0
    Top = 41
    Width = 312
    Height = 87
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object ExpressionLabel: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 306
      Height = 15
      Align = alTop
      Alignment = taRightJustify
      Caption = '50 x 2'
    end
    object DisplayLabel: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 24
      Width = 306
      Height = 60
      Align = alClient
      Alignment = taRightJustify
      Caption = '123,456'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -43
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object ButtonsGridPanel: TGridPanel
    Left = 0
    Top = 128
    Width = 312
    Height = 335
    Align = alClient
    ColumnCollection = <
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = ButtonPercent
        Row = 0
      end
      item
        Column = 1
        Control = ButtonBlank
        Row = 0
      end
      item
        Column = 2
        Control = ButtonClearAll
        Row = 0
      end
      item
        Column = 3
        Control = ButtonBack
        Row = 0
      end
      item
        Column = 0
        Control = ButtonReciprocal
        Row = 1
      end
      item
        Column = 1
        Control = ButtonSquare
        Row = 1
      end
      item
        Column = 2
        Control = ButtonSqrt
        Row = 1
      end
      item
        Column = 3
        Control = ButtonDivide
        Row = 1
      end
      item
        Column = 0
        Control = Button7
        Row = 2
      end
      item
        Column = 1
        Control = Button8
        Row = 2
      end
      item
        Column = 2
        Control = Button9
        Row = 2
      end
      item
        Column = 3
        Control = ButtonMultiply
        Row = 2
      end
      item
        Column = 0
        Control = Button4
        Row = 3
      end
      item
        Column = 1
        Control = Button5
        Row = 3
      end
      item
        Column = 2
        Control = Button6
        Row = 3
      end
      item
        Column = 3
        Control = ButtonMinus
        Row = 3
      end
      item
        Column = 0
        Control = Button1
        Row = 4
      end
      item
        Column = 1
        Control = Button2
        Row = 4
      end
      item
        Column = 2
        Control = Button3
        Row = 4
      end
      item
        Column = 3
        Control = ButtonAdd
        Row = 4
      end
      item
        Column = 0
        Control = ButtonPlusMinus
        Row = 5
      end
      item
        Column = 1
        Control = Button0
        Row = 5
      end
      item
        Column = 2
        Control = ButtonDecimal
        Row = 5
      end
      item
        Column = 3
        Control = ButtonEqual
        Row = 5
      end>
    RowCollection = <
      item
        Value = 16.666666666666660000
      end
      item
        Value = 16.666666666666660000
      end
      item
        Value = 16.666666666666660000
      end
      item
        Value = 16.666666666666660000
      end
      item
        Value = 16.666666666666660000
      end
      item
        Value = 16.666666666666700000
      end>
    TabOrder = 2
    object ButtonPercent: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 72
      Height = 49
      Cursor = crHandPoint
      Action = PercentAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object ButtonBlank: TButton
      AlignWithMargins = True
      Left = 82
      Top = 4
      Width = 71
      Height = 49
      Cursor = crHandPoint
      Action = ClearEntryAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object ButtonClearAll: TButton
      AlignWithMargins = True
      Left = 159
      Top = 4
      Width = 72
      Height = 49
      Cursor = crHandPoint
      Action = ClearAllAction
      Align = alClient
      Cancel = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object ButtonBack: TButton
      AlignWithMargins = True
      Left = 237
      Top = 4
      Width = 71
      Height = 49
      Cursor = crHandPoint
      Action = BackAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object ButtonReciprocal: TButton
      AlignWithMargins = True
      Left = 4
      Top = 59
      Width = 72
      Height = 50
      Cursor = crHandPoint
      Action = ReciprocalAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object ButtonSquare: TButton
      AlignWithMargins = True
      Left = 82
      Top = 59
      Width = 71
      Height = 50
      Cursor = crHandPoint
      Action = SquareAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object ButtonSqrt: TButton
      AlignWithMargins = True
      Left = 159
      Top = 59
      Width = 72
      Height = 50
      Cursor = crHandPoint
      Action = SqrtAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object ButtonDivide: TButton
      AlignWithMargins = True
      Left = 237
      Top = 59
      Width = 71
      Height = 50
      Cursor = crHandPoint
      Action = DivideAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
    end
    object Button7: TButton
      Tag = 7
      AlignWithMargins = True
      Left = 4
      Top = 115
      Width = 72
      Height = 49
      Cursor = crHandPoint
      Align = alClient
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = DigitButtonClick
    end
    object Button8: TButton
      Tag = 8
      AlignWithMargins = True
      Left = 82
      Top = 115
      Width = 71
      Height = 49
      Cursor = crHandPoint
      Align = alClient
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = DigitButtonClick
    end
    object Button9: TButton
      Tag = 9
      AlignWithMargins = True
      Left = 159
      Top = 115
      Width = 72
      Height = 49
      Cursor = crHandPoint
      Align = alClient
      Caption = '9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = DigitButtonClick
    end
    object ButtonMultiply: TButton
      AlignWithMargins = True
      Left = 237
      Top = 115
      Width = 71
      Height = 49
      Cursor = crHandPoint
      Action = MultiplyAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
    end
    object Button4: TButton
      Tag = 4
      AlignWithMargins = True
      Left = 4
      Top = 170
      Width = 72
      Height = 50
      Cursor = crHandPoint
      Align = alClient
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = DigitButtonClick
    end
    object Button5: TButton
      Tag = 5
      AlignWithMargins = True
      Left = 82
      Top = 170
      Width = 71
      Height = 50
      Cursor = crHandPoint
      Align = alClient
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      OnClick = DigitButtonClick
    end
    object Button6: TButton
      Tag = 6
      AlignWithMargins = True
      Left = 159
      Top = 170
      Width = 72
      Height = 50
      Cursor = crHandPoint
      Align = alClient
      Caption = '6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnClick = DigitButtonClick
    end
    object ButtonMinus: TButton
      AlignWithMargins = True
      Left = 237
      Top = 170
      Width = 71
      Height = 50
      Cursor = crHandPoint
      Action = SubtractAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
    end
    object Button1: TButton
      Tag = 1
      AlignWithMargins = True
      Left = 4
      Top = 226
      Width = 72
      Height = 49
      Cursor = crHandPoint
      Align = alClient
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      OnClick = DigitButtonClick
    end
    object Button2: TButton
      Tag = 2
      AlignWithMargins = True
      Left = 82
      Top = 226
      Width = 71
      Height = 49
      Cursor = crHandPoint
      Align = alClient
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      OnClick = DigitButtonClick
    end
    object Button3: TButton
      Tag = 3
      AlignWithMargins = True
      Left = 159
      Top = 226
      Width = 72
      Height = 49
      Cursor = crHandPoint
      Align = alClient
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
      OnClick = DigitButtonClick
    end
    object ButtonAdd: TButton
      AlignWithMargins = True
      Left = 237
      Top = 226
      Width = 71
      Height = 49
      Cursor = crHandPoint
      Action = AddAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 19
    end
    object ButtonPlusMinus: TButton
      AlignWithMargins = True
      Left = 4
      Top = 281
      Width = 72
      Height = 50
      Cursor = crHandPoint
      Action = NegateAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 20
    end
    object Button0: TButton
      AlignWithMargins = True
      Left = 82
      Top = 281
      Width = 71
      Height = 50
      Cursor = crHandPoint
      Align = alClient
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 21
      OnClick = DigitButtonClick
    end
    object ButtonDecimal: TButton
      AlignWithMargins = True
      Left = 159
      Top = 281
      Width = 72
      Height = 50
      Cursor = crHandPoint
      Action = DecimalSepAction
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 22
    end
    object ButtonEqual: TButton
      AlignWithMargins = True
      Left = 237
      Top = 281
      Width = 71
      Height = 50
      Cursor = crHandPoint
      Action = EqualAction
      Align = alClient
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 23
    end
  end
  object VirtualImageList: TVirtualImageList
    Images = <
      item
        CollectionIndex = 155
        CollectionName = 'menu'
        Name = 'menu'
      end>
    ImageCollection = dmResources.ImageCollection
    Left = 176
    Top = 8
  end
  object ActionList: TActionList
    Left = 96
    Top = 64
    object AddAction: TAction
      Caption = '+'
      OnExecute = AddActionExecute
    end
    object SubtractAction: TAction
      Caption = #8722
      OnExecute = SubtractActionExecute
    end
    object MultiplyAction: TAction
      Caption = #215
      OnExecute = MultiplyActionExecute
    end
    object DivideAction: TAction
      Caption = #247
      OnExecute = DivideActionExecute
    end
    object SqrtAction: TAction
      Caption = #8730'x'
      OnExecute = SqrtActionExecute
    end
    object SquareAction: TAction
      Caption = 'x'#178
      OnExecute = SquareActionExecute
    end
    object ReciprocalAction: TAction
      Caption = #185#8725'x'
      OnExecute = ReciprocalActionExecute
    end
    object PercentAction: TAction
      Caption = '%'
      OnExecute = PercentActionExecute
    end
    object NegateAction: TAction
      Caption = #177
      OnExecute = NegateActionExecute
    end
    object EqualAction: TAction
      Caption = '='
      OnExecute = EqualActionExecute
    end
    object BackAction: TAction
      Caption = #9003
      OnExecute = BackActionExecute
    end
    object ClearAllAction: TAction
      Caption = 'C'
      OnExecute = ClearAllActionExecute
    end
    object DecimalSepAction: TAction
      Caption = ','
      OnExecute = DecimalSepActionExecute
    end
    object DigitAction: TAction
    end
    object ClearEntryAction: TAction
      Caption = 'CE'
      OnExecute = ClearEntryActionExecute
    end
  end
end
