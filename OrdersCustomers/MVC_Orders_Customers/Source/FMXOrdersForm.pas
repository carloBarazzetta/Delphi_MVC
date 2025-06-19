{******************************************************************************}
{       Orders/Customers MVC: An Orders/Customers with MVC Pattern (VCL+FMX)   }
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
unit FMXOrdersForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, 
  FMX.Layouts, FMX.TreeView, FMX.Grid, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox
  , System.Generics.Collections
  , AppController
  , Model
  , Orders, Order
  , Customers, Customer;

type
  TFMXOrdersFrm = class(TForm, IInterface, IOrdersView)
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
    FModel: TModel;
    //IView Interface
    procedure SetModelAndController(const AModel: TModel;
      const AController: TAppController);
    procedure RefreshView;
    //IOrdersView Interface
    procedure DisplayOrders(const ACustomer: TCustomer = nil);
  private
    FCurrentCustomer: TCustomer;
    procedure RefreshOrderList;
    procedure SetCurrentCustomer(const Value: TCustomer);
    function GetCurrentOrder: TOrder;
  public
    property CurrentCustomer: TCustomer read FCurrentCustomer write SetCurrentCustomer;
  end;

implementation

{$R *.fmx}

{ TFMXOrdersFrm }

procedure TFMXOrdersFrm.ButtonAddClick(Sender: TObject);
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

function TFMXOrdersFrm.GetCurrentOrder: TOrder;
begin
  var LIndex := OrdersListView.Selected;
  if LIndex >= 0 then
  begin
    var LOrderId := StrToInt(OrdersListView.Cells[0, LIndex]);
    Result := FController.RetrieveOrder(LOrderId);
  end
  else
    Result := nil;
end;

procedure TFMXOrdersFrm.ButtonDeleteClick(Sender: TObject);
begin
  var LOrder := GetCurrentOrder;
  if Assigned(LOrder) then
      FController.DeleteOrder(LOrder.Id);
end;

procedure TFMXOrdersFrm.DisplayOrders(const ACustomer: TCustomer = nil);
begin
  FCurrentCustomer := ACustomer;
  Show;
  RefreshView;
end;

procedure TFMXOrdersFrm.SetCurrentCustomer(const Value: TCustomer);
begin
  FCurrentCustomer := Value;
  RefreshView;
end;

procedure TFMXOrdersFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TFMXOrdersFrm.RefreshOrderList;
var
  LOrder: TOrder;
  I: Integer;
begin
  var LOrders := FModel.Orders.GetAllOrders(FCurrentCustomer);
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

procedure TFMXOrdersFrm.RefreshView;
begin
  if FCurrentCustomer <> nil then
    Caption := Format('%s - Customer: %s', [Caption,FCurrentCustomer.Name]);
  RefreshOrderList;
end;

end.
