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
unit VCLOrdersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.NumberBox
  , System.Generics.Collections
  , AppController
  , Model
  , Orders, Order
  , Customers, Customer;

type
  TVCLOrdersFrm = class(TForm, IInterface, IOrdersView)
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    OrdersListView: TListView;
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

{$R *.dfm}

{ TVCLOrdersFrm }

procedure TVCLOrdersFrm.ButtonAddClick(Sender: TObject);
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

function TVCLOrdersFrm.GetCurrentOrder: TOrder;
begin
  var LIndex := OrdersListView.ItemIndex;
  if LIndex >= 0 then
  begin
    var LOrderId := StrToInt(OrdersListView.Items[LIndex].Caption);
    Result := FController.RetrieveOrder(LOrderId);
  end
  else
    Result := nil;
end;

procedure TVCLOrdersFrm.ButtonDeleteClick(Sender: TObject);
begin
  var LOrder := GetCurrentOrder;
  if Assigned(LOrder) then
      FController.DeleteOrder(LOrder.Id);
end;

procedure TVCLOrdersFrm.DisplayOrders(const ACustomer: TCustomer = nil);
begin
  FCurrentCustomer := ACustomer;
  Show;
  RefreshView;
end;

procedure TVCLOrdersFrm.SetCurrentCustomer(const Value: TCustomer);
begin
  FCurrentCustomer := Value;
  RefreshView;
end;

procedure TVCLOrdersFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TVCLOrdersFrm.RefreshOrderList;
begin
  var LOrders := FModel.Orders.GetAllOrders(FCurrentCustomer);
  OrdersListView.Items.BeginUpdate;
  try
    OrdersListView.Clear;

    for var LOrder in LOrders do
      with OrdersListView.Items.Add do
      begin
        Caption := IntToStr(LOrder.Id);
        SubItems.Add(LOrder.Text);
        SubItems.Add(FloatToStr(LOrder.FullPrice));
        SubItems.Add(FloatToStr(LOrder.DiscountedPrice));
      end;
  finally
    OrdersListView.Items.EndUpdate;
  end;
end;

procedure TVCLOrdersFrm.RefreshView;
begin
  if FCurrentCustomer <> nil then
    Caption := Format('%s - Customer: %s', [Caption,FCurrentCustomer.Name]);
  RefreshOrderList;
end;

end.
