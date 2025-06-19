object VCLOrdersFrm: TVCLOrdersFrm
  Left = 0
  Top = 0
  Caption = 'Orders List'
  ClientHeight = 426
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 13
  object OrdersListView: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 550
    Height = 369
    Align = alClient
    Columns = <
      item
        Caption = 'Id'
      end
      item
        Caption = 'Text'
        Width = 150
      end
      item
        Caption = 'Full Price'
        Width = 100
      end
      item
        Caption = 'Discounted Price'
        Width = 100
      end
      item
        Caption = 'Customer'
        Width = 100
      end>
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = OrdersListViewDblClick
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 459
    ExplicitHeight = 268
  end
  object DataPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 378
    Width = 550
    Height = 45
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 384
    ExplicitWidth = 556
    DesignSize = (
      550
      45)
    object ButtonDelete: TButton
      Left = 467
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Delete'
      TabOrder = 4
      OnClick = ButtonDeleteClick
      ExplicitLeft = 473
    end
    object DiscountPriceEdit: TNumberBox
      Left = 231
      Top = 8
      Width = 90
      Height = 21
      Alignment = taRightJustify
      Decimal = 4
      DisplayFormat = '#.###,####'
      Mode = nbmCurrency
      TabOrder = 2
      Value = 100456.789000000000000000
    end
    object FullPriceEdit: TNumberBox
      Left = 135
      Top = 8
      Width = 90
      Height = 21
      Alignment = taRightJustify
      Decimal = 4
      DisplayFormat = '#.###,####'
      Mode = nbmCurrency
      TabOrder = 1
      Value = 123456.789000000000000000
    end
    object OrderTextEdit: TEdit
      Left = 8
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Order No. 3'
    end
    object ButtonAdd: TButton
      Left = 386
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Add'
      TabOrder = 3
      OnClick = ButtonAddClick
      ExplicitLeft = 392
    end
  end
end
