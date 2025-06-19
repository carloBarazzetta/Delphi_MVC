object VCLCustomersFrm: TVCLCustomersFrm
  Left = 0
  Top = 0
  Caption = 'Customers List'
  ClientHeight = 522
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object CustomersListView: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 570
    Height = 281
    Align = alClient
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
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = CustomersListViewDblClick
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 606
    ExplicitHeight = 153
  end
  object OrdersPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 336
    Width = 570
    Height = 183
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitWidth = 600
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 290
    Width = 570
    Height = 40
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitLeft = -3
    ExplicitTop = 296
    ExplicitWidth = 576
    DesignSize = (
      570
      40)
    object ButtonAdd: TButton
      Left = 406
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Add'
      TabOrder = 3
      OnClick = ButtonAddClick
      ExplicitLeft = 442
    end
    object ButtonDelete: TButton
      Left = 487
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Delete'
      TabOrder = 4
      OnClick = ButtonDeleteClick
      ExplicitLeft = 523
    end
    object CompanyNameEdit: TEdit
      Left = 8
      Top = 10
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Ethea S.r.l.'
    end
    object FirstNameEdit: TEdit
      Left = 135
      Top = 10
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'Carlo'
    end
    object LastNameEdit: TEdit
      Left = 262
      Top = 10
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'Barazzetta'
    end
  end
end
