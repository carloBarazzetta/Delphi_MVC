{******************************************************************************}
{       Simple MVC: A Simple Order Manager with MVC Pattern (VCL+FMX+Console)  }
{       Copyright (c) 2025 (Ethea S.r.l.)                                      }
{       Author: Carlo Barazzetta                                               }
{       Contributors:                                                          }
{       https://github.com/carloBarazzetta/Delphi_MVC                          }
{******************************************************************************}
{  Licensed under the Apache License, Version 2.0 (the "License");             }
{  you may not use this file except in compliance with the License.            }
{  You may obtain a copy of the License at                                     }
{      http://www.apache.org/licenses/LICENSE-2.0                              }
{  Unless required by applicable law or agreed to in writing, software         }
{  distributed under the License is distributed on an "AS IS" BASIS,           }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    }
{  See the License for the specific language governing permissions and         }
{  limitations under the License.                                              }
{******************************************************************************}
unit FMXMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, AppController, Orders,
  FMX.Layouts, FMX.TreeView, FMX.Grid, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox,
  FMX.NumberBox;

type
  TFMXMainFrm = class(TForm, IView)
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    OrdersListView: TStringGrid;
    IntegerColumn1: TIntegerColumn;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    OrderTextEdit: TEdit;
    FullPriceEdit: TNumberBox;
    DiscountPriceEdit: TNumberBox;
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
  strict private
    FController: TAppController;
    FModel: TOrders;
    //IView Interface
    procedure SetController(const Value: TAppController);
    procedure SetModel(const Value: TOrders);
    procedure RefreshView;
  end;

implementation

{$R *.fmx}

uses Order, System.Generics.Collections;

{ TFMXMainFrm }

procedure TFMXMainFrm.ButtonAddClick(Sender: TObject);
begin
  var Order := TOrder.Create;
  try
    Order.Text := OrderTextEdit.Text;
    Order.FullPrice := FullPriceEdit.Value;
    Order.DiscountedPrice := DiscountPriceEdit.Value;
    FController.AddOrder(Order);
  except
    Order.Free;
    raise;
  end;
end;

procedure TFMXMainFrm.ButtonDeleteClick(Sender: TObject);
begin
  var LIndex := OrdersListView.Selected;
  if LIndex >= 0 then
  begin
    var LOrderId := StrToInt(OrdersListView.Cells[0, LIndex]);
    FController.DeleteOrder(LOrderId);
  end;
end;

procedure TFMXMainFrm.SetController(const Value: TAppController);
begin
  FController := Value;
  Caption := FController.AppTitle + ' - FMX';
end;

procedure TFMXMainFrm.SetModel(const Value: TOrders);
begin
  FModel := Value;
end;

procedure TFMXMainFrm.RefreshView;
var
  LOrders: TObjectList<TOrder>;
  LOrder: TOrder;
  I: Integer;
begin
  LOrders := FModel.GetAllOrders();
  OrdersListView.RowCount := LOrders.Count;
  I := 0;
  for LOrder in LOrders do
  begin
    OrdersListView.Cells[0, I] := IntToStr(LOrder.Id);
    OrdersListView.Cells[1, I] := LOrder.Text;
    OrdersListView.Cells[2, I] := FloatToStr(LOrder.FullPrice);
    OrdersListView.Cells[3, I] := FloatToStr(LOrder.DiscountedPrice);
    Inc(I);
  end;
end;

end.
