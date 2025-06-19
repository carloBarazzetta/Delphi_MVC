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
unit VCLCustomersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.NumberBox
  , System.Generics.Collections
  , AppController
  , Model
  , Customers
  , Customer, Vcl.ExtCtrls;

type
  TVCLCustomersFrm = class(TForm, IInterface, ICustomersView, IContainerView)
    CustomersListView: TListView;
    OrdersPanel: TPanel;
    Panel1: TPanel;
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    CompanyNameEdit: TEdit;
    FirstNameEdit: TEdit;
    LastNameEdit: TEdit;
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonSelectClick(Sender: TObject);
    procedure CustomersListViewDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
    FController: TAppController;
    FModel: TModel;
    //IView Interface
    procedure SetModelAndController(const AModel: TModel;
      const AController: TAppController);
    procedure RefreshView;
    //ICustomerView Interface
    procedure DisplayCustomers;
    //IContainerView Interface
    procedure DisplayEmbeddedView(const AView: IView);
  private
    FOrdersView: IView;
    function GetCurrentCustomer: TCustomer;
  end;

implementation

{$R *.dfm}

{ TVCLMainFrm }

procedure TVCLCustomersFrm.ButtonAddClick(Sender: TObject);
begin
  var Customer := TCustomer.Create(FModel);
  try
    Customer.CompanyName := CompanyNameEdit.Text;
    Customer.FirstName := FirstNameEdit.Text;
    Customer.LastName := LastNameEdit.Text;
    //Other Customer fields...
    FController.AddCustomer(Customer);
  except
    Customer.Free;
    raise;
  end;
end;

procedure TVCLCustomersFrm.ButtonDeleteClick(Sender: TObject);
begin
  var LCustomer := GetCurrentCustomer;
  if Assigned(LCustomer) then
      FController.DeleteCustomer(LCustomer.Id);
end;

procedure TVCLCustomersFrm.ButtonSelectClick(Sender: TObject);
begin
  ;
end;

procedure TVCLCustomersFrm.CustomersListViewDblClick(Sender: TObject);
begin
  var LCustomer := GetCurrentCustomer;
  //Call Orders View filtered By Customer
  FController.CreateOrdersView(Self, LCustomer);
end;

procedure TVCLCustomersFrm.DisplayCustomers;
begin
  Show;
  RefreshView;
end;

procedure TVCLCustomersFrm.DisplayEmbeddedView(const AView: IView);
begin
  if Assigned(FOrdersView) then
  begin
    (FOrdersView as TForm).Free;
    FOrdersView := nil;
  end;
  var LForm := AView as TForm;
  LForm.Parent := OrdersPanel;
  LForm.Align := alClient;
  LForm.BorderIcons := [];
  LForm.BorderStyle := bsNone;
  LForm.Show;
  FOrdersView := AView;
end;

procedure TVCLCustomersFrm.FormCreate(Sender: TObject);
begin
  ;
end;

procedure TVCLCustomersFrm.FormDestroy(Sender: TObject);
begin
  ;
end;

function TVCLCustomersFrm.GetCurrentCustomer: TCustomer;
begin
  var LIndex := CustomersListView.ItemIndex;
  if LIndex >= 0 then
  begin
    var LCustomerId := StrToInt(CustomersListView.Items[LIndex].Caption);
    Result := FController.RetrieveCustomer(LCustomerId);
  end
  else
    Result := nil;
end;

procedure TVCLCustomersFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TVCLCustomersFrm.RefreshView;
var
  LCustomers: TList<TCustomer>;
  LCustomer: TCustomer;
begin
  LCustomers := FModel.Customers.GetAllCustomers();
  CustomersListView.Items.BeginUpdate;
  try
    CustomersListView.Clear;

    for LCustomer in LCustomers do
      with CustomersListView.Items.Add do
      begin
        Caption := IntToStr(LCustomer.Id);
        SubItems.Add(LCustomer.CompanyName);
        SubItems.Add(LCustomer.FirstName);
        SubItems.Add(LCustomer.LastName);
        SubItems.Add(LCustomer.Country.Name);
      end;
  finally
    CustomersListView.Items.EndUpdate;
  end;

  if Assigned(FOrdersView) then
    FOrdersView.RefreshView;

end;

end.
