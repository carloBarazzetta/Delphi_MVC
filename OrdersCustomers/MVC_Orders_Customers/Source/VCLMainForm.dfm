object VCLMainFrm: TVCLMainFrm
  Left = 0
  Top = 0
  Caption = 'VCLMainFrm'
  ClientHeight = 442
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  OnClose = FormClose
  TextHeight = 13
  object ClientPanel: TPanel
    Left = 0
    Top = 0
    Width = 756
    Height = 442
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
  end
  object MainMenu: TMainMenu
    Left = 232
    Top = 176
    object DataMenuItem: TMenuItem
      Caption = 'Data'
      object OrdersMenuItem: TMenuItem
        Caption = 'Orders'
        OnClick = OrdersMenuItemClick
      end
      object CustomersMenuItem: TMenuItem
        Caption = 'Customers'
        OnClick = CustomersMenuItemClick
      end
      object CountriesMenuItem: TMenuItem
        Caption = 'Countries'
      end
    end
  end
end
