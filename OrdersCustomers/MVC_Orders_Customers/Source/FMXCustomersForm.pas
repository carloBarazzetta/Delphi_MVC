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
unit FMXCustomersForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.Layouts, FMX.TreeView, FMX.Grid, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox,
  FMX.NumberBox
  , System.Generics.Collections
  , AppController
  , Model
  , Customers
  , Customer;

type
  TFMXCustomersFrm = class(TForm, ICustomersView)
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    CustomersListView: TStringGrid;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    CompanyNameEdit: TEdit;
    FirstNameEdit: TEdit;
    LastNameEdit: TEdit;
    ButtonSelect: TButton;
    StringColumn4: TStringColumn;
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonSelectClick(Sender: TObject);
    procedure CustomersListViewCellDblClick(const Column: TColumn;
      const Row: Integer);
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
    procedure RefreshCustomerList;
  end;

implementation

{$R *.fmx}

{ TFMXOrdersFrm }

procedure TFMXCustomersFrm.ButtonAddClick(Sender: TObject);
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

procedure TFMXCustomersFrm.ButtonDeleteClick(Sender: TObject);
begin
  var LCustomer := GetCurrentCustomer;
  if Assigned(LCustomer) then
      FController.DeleteCustomer(LCustomer.Id);
end;

procedure TFMXCustomersFrm.ButtonSelectClick(Sender: TObject);
begin
  ;
end;

procedure TFMXCustomersFrm.CustomersListViewCellDblClick(
  const Column: TColumn; const Row: Integer);
begin
  var LCustomer := GetCurrentCustomer;
  //Call Orders View filtered By Customer
  FController.CreateOrdersView(nil, LCustomer);
end;

procedure TFMXCustomersFrm.DisplayCustomers;
begin
  Show;
  RefreshView;
end;

procedure TFMXCustomersFrm.FormCreate(Sender: TObject);
begin
  ;
end;

procedure TFMXCustomersFrm.FormDestroy(Sender: TObject);
begin
  ;
end;

function TFMXCustomersFrm.GetCurrentCustomer: TCustomer;
begin
  var LIndex := CustomersListView.Selected;
  if LIndex >= 0 then
  begin
    var LCustomerId := StrToInt(CustomersListView.Cells[0, LIndex]);;
    Result := FController.RetrieveCustomer(LCustomerId);
  end
  else
    Result := nil;
end;

procedure TFMXCustomersFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TFMXCustomersFrm.RefreshView;
begin
  RefreshCustomerList;
end;

procedure TFMXCustomersFrm.RefreshCustomerList;
var
  LCustomer: TCustomer;
  I: Integer;
begin
  var LCustomers := FModel.Customers.GetAllCustomers;
  CustomersListView.RowCount := LCustomers.Count;
  I := 0;
  for LCustomer in LCustomers do
  begin
    CustomersListView.Cells[0, I] := IntToStr(LCustomer.Id);
    CustomersListView.Cells[1, I] := LCustomer.CompanyName;
    CustomersListView.Cells[2, I] := LCustomer.FirstName;
    CustomersListView.Cells[3, I] := LCustomer.LastName;
    Inc(I);
  end;
end;

end.
