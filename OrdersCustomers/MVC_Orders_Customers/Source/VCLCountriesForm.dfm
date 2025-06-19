object VCLCountriesFrm: TVCLCountriesFrm
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
  object CountriesListView: TListView
    Left = 8
    Top = 8
    Width = 459
    Height = 330
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = 'IsoCode'
      end
      item
        Caption = 'Name'
        Width = 150
      end>
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
end
