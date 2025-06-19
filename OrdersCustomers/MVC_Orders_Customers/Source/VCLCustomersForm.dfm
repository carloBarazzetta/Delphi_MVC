object VCLCustomersFrm: TVCLCustomersFrm
  Left = 0
  Top = 0
  Caption = 'Customers List'
  ClientHeight = 346
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    560
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
    Left = 477
    Top = 73
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Delete'
    TabOrder = 4
    OnClick = ButtonDeleteClick
  end
  object CustomersListView: TListView
    Left = 8
    Top = 104
    Width = 544
    Height = 209
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = 'Id'
      end
      item
        Caption = 'Company Name'
        Width = 150
      end
      item
        Caption = 'First Name'
        Width = 100
      end
      item
        Caption = 'Last Name'
        Width = 100
      end
      item
        Caption = 'Country'
        Width = 100
      end>
    RowSelect = True
    TabOrder = 5
    ViewStyle = vsReport
    OnDblClick = CustomersListViewDblClick
  end
  object CompanyNameEdit: TEdit
    Left = 8
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Ethea S.r.l.'
  end
  object FirstNameEdit: TEdit
    Left = 135
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Carlo'
  end
  object LastNameEdit: TEdit
    Left = 262
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Barazzetta'
  end
  object ButtonSelect: TButton
    Left = 477
    Top = 319
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Select'
    TabOrder = 6
    OnClick = ButtonSelectClick
  end
end
