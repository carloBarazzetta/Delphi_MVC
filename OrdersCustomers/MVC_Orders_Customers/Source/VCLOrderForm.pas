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
unit VCLOrderForm;

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
  TVCLOrderFrm = class(TForm, IInterface, IOrderView)
    ButtonSave: TButton;
    ButtonCancel: TButton;
    OrderTextEdit: TEdit;
    FullPriceEdit: TNumberBox;
    DiscountPriceEdit: TNumberBox;
    EditCustomer: TEdit;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FController: TAppController;
    FModel: TModel;
    //IView Interface
    procedure SetModelAndController(const AModel: TModel;
      const AController: TAppController);
    procedure RefreshView;
    //IOrderView Interface
    procedure DisplayOrder(const AOrder: TOrder;
      const ACustomer: TCustomer = nil);
  private
    FEditOrder: TOrder;
    FCurrentCustomer: TCustomer;
    procedure RefreshOrder;
    procedure SetCurrentOrder(const Value: TOrder);
    procedure SetCurrentCustomer(const Value: TCustomer);
  public
    property CurrentOrder: TOrder read FEditOrder write SetCurrentOrder;
    property CurrentCustomer: TCustomer read FCurrentCustomer write SetCurrentCustomer;
  end;

implementation

{$R *.dfm}

{ TVCLOrdersFrm }

procedure TVCLOrderFrm.ButtonSaveClick(Sender: TObject);
begin
  FEditOrder.Text := OrderTextEdit.Text;
  FEditOrder.FullPrice := FullPriceEdit.Value;
  FEditOrder.DiscountedPrice := DiscountPriceEdit.Value;
  FController.SaveOrder(FEditOrder);
  Close;
end;

procedure TVCLOrderFrm.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TVCLOrderFrm.DisplayOrder(
  const AOrder: TOrder;
  const ACustomer: TCustomer = nil);
begin
  FEditOrder.Assign(AOrder);
  FCurrentCustomer := ACustomer;
  if Assigned(ACustomer) then
    FEditOrder.Customer := ACustomer;
  Show;
  RefreshView;
end;

procedure TVCLOrderFrm.FormCreate(Sender: TObject);
begin
  FEditOrder := TOrder.Create;
end;

procedure TVCLOrderFrm.FormDestroy(Sender: TObject);
begin
  FEditOrder.Free;
end;

procedure TVCLOrderFrm.SetCurrentCustomer(const Value: TCustomer);
begin
  FCurrentCustomer := Value;
  RefreshView;
end;

procedure TVCLOrderFrm.SetCurrentOrder(const Value: TOrder);
begin
  FEditOrder := Value;
  RefreshView;
end;

procedure TVCLOrderFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TVCLOrderFrm.RefreshOrder;
begin
  OrderTextEdit.Text := FEditOrder.Text;
  FullPriceEdit.Value := FEditOrder.FullPrice;
  DiscountPriceEdit.Value := FEditOrder.DiscountedPrice;
  if Assigned(FEditOrder.Customer) then
    EditCustomer.Text := FEditOrder.Customer.Name
  else
    EditCustomer.Text := '';
end;

procedure TVCLOrderFrm.RefreshView;
begin
  if FCurrentCustomer <> nil then
    Caption := Format('%s - Customer: %s', [Caption,FCurrentCustomer.Name]);
  RefreshOrder;
end;

end.
