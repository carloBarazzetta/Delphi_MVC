object VCLOrderFrm: TVCLOrderFrm
  Left = 0
  Top = 0
  Caption = 'Order Edit'
  ClientHeight = 217
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    306
    217)
  TextHeight = 13
  object ButtonSave: TButton
    Left = 142
    Top = 184
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Default = True
    TabOrder = 4
    OnClick = ButtonSaveClick
  end
  object ButtonCancel: TButton
    Left = 223
    Top = 184
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 5
    OnClick = ButtonCancelClick
  end
  object OrderTextEdit: TEdit
    Left = 8
    Top = 59
    Width = 194
    Height = 21
    TabOrder = 1
  end
  object FullPriceEdit: TNumberBox
    Left = 8
    Top = 99
    Width = 90
    Height = 21
    Alignment = taRightJustify
    Decimal = 4
    DisplayFormat = '#.###,####'
    Mode = nbmCurrency
    TabOrder = 2
  end
  object DiscountPriceEdit: TNumberBox
    Left = 112
    Top = 99
    Width = 90
    Height = 21
    Alignment = taRightJustify
    Decimal = 4
    DisplayFormat = '#.###,####'
    Mode = nbmCurrency
    TabOrder = 3
  end
  object EditCustomer: TEdit
    Left = 8
    Top = 21
    Width = 194
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
end
