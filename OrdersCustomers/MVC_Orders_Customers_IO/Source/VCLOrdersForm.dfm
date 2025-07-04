object VCLOrdersFrm: TVCLOrdersFrm
  Left = 0
  Top = 0
  Caption = 'Orders List'
  ClientHeight = 346
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    475
    346)
  TextHeight = 13
  object ButtonAdd: TButton
    Left = 8
    Top = 73
    Width = 75
    Height = 25
    Caption = '&Add'
    TabOrder = 3
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 392
    Top = 73
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Delete'
    TabOrder = 4
    OnClick = ButtonDeleteClick
  end
  object CustomersListView: TDBGrid
    Left = 8
    Top = 102
    Width = 459
    Height = 236
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = OrdersSource
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object OrderTextEdit: TEdit
    Left = 8
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Order No. 3'
  end
  object FullPriceEdit: TNumberBox
    Left = 135
    Top = 35
    Width = 90
    Height = 21
    Alignment = taRightJustify
    Decimal = 4
    DisplayFormat = '#.###,####'
    Mode = nbmCurrency
    TabOrder = 1
    Value = 123456.789000000000000000
  end
  object DiscountPriceEdit: TNumberBox
    Left = 231
    Top = 35
    Width = 90
    Height = 21
    Alignment = taRightJustify
    Decimal = 4
    DisplayFormat = '#.###,####'
    Mode = nbmCurrency
    TabOrder = 2
    Value = 100456.789000000000000000
  end
  object OrdersSelector: TInstantSelector
    Command.Strings = (
      'SELECT * FROM TOrder')
    ObjectClassName = 'TOrder'
    Left = 256
    Top = 176
  end
  object OrdersSource: TDataSource
    AutoEdit = False
    DataSet = OrdersSelector
    Left = 272
    Top = 240
  end
end
