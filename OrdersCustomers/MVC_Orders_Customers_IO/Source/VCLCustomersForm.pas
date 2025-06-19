{******************************************************************************}
{       Orders/Customers IO: An Orders/Customers with MVC and InstantObjects   }
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
  Vcl.ComCtrls, Vcl.NumberBox, Vcl.DBGrids, Data.DB
  , System.Generics.Collections
  , AppController
  , Model
  , Customers
  , Customer
  , InstantPresentation;

type
  TVCLCustomersFrm = class(TForm, IInterface, ICustomersView)
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    CustomersListView: TDBGrid;
    CompanyNameEdit: TEdit;
    FirstNameEdit: TEdit;
    LastNameEdit: TEdit;
    ButtonSelect: TButton;
    CustomersSelector: TInstantSelector;
    CustomersSource: TDataSource;
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
  private
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
  FController.CreateOrdersView(nil, LCustomer);
end;

procedure TVCLCustomersFrm.DisplayCustomers;
begin
  Show;
  RefreshView;
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
  Result := CustomersSelector.CurrentObject as TCustomer;
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
  CustomersSelector.DisableControls;
  try
    for LCustomer in LCustomers do
    begin
      CustomersSelector.AddObject(LCustomer);
    end;
    CustomersSelector.Open;
  finally
    CustomersSelector.EnableControls;
  end;
end;

end.
