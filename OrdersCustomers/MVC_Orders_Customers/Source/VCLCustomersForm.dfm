object VCLCustomersFrm: TVCLCustomersFrm
  Left = 0
  Top = 0
  Caption = 'Customers List'
  ClientHeight = 522
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    606
    522)
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
    Left = 523
    Top = 73
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Delete'
    TabOrder = 4
    OnClick = ButtonDeleteClick
    ExplicitLeft = 477
  end
  object CustomersListView: TListView
    Left = 8
    Top = 104
    Width = 590
    Height = 129
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
    Left = 523
    Top = 495
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Select'
    TabOrder = 6
    OnClick = ButtonSelectClick
    ExplicitLeft = 477
    ExplicitTop = 319
  end
  object OrdersPanel: TPanel
    Left = 8
    Top = 239
    Width = 590
    Height = 235
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 7
  end
end
