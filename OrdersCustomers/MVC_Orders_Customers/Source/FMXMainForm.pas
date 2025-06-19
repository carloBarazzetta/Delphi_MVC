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
unit FMXMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Rtti, 
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, 
  FMX.Layouts, FMX.TreeView, FMX.Grid, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Controls.Presentation, FMX.StdCtrls,
  AppController, Model, Orders;

type
  TFMXMainFrm = class(TForm, IInterface, IContainerView)
    TopLayout: TLayout;
    ButtonOrders: TButton;
    ButtonCustomers: TButton;
    ButtonCountries: TButton;
    procedure OrdersMenuItemClick(Sender: TObject);
    procedure CustomersMenuItemClick(Sender: TObject);
    procedure CountriesMenuItemClick(Sender: TObject);
  strict private
    FController: TAppController;
    FModel: TModel;
    FCurrentView: IView;
    //IView Interface
    procedure SetModelAndController(const AModel: TModel;
      const AController: TAppController);
    procedure RefreshView;
    //IContainerView Interface
    procedure DisplayEmbeddedView(const AView: IView);
  private
    procedure SetCurrentView(const Value: IView);
    property CurrentView: IView Read FCurrentView write SetCurrentView;
  end;

implementation

{$R *.fmx}

uses Order 
  , System.Generics.Collections
  , FMXOrdersForm
  , FMXCustomersForm
  ;

{ TFMXMainFrm }

procedure TFMXMainFrm.CountriesMenuItemClick(Sender: TObject);
begin
  CurrentView := FController.CreateCountriesView(nil);
end;

procedure TFMXMainFrm.CustomersMenuItemClick(Sender: TObject);
begin
  CurrentView := FController.CreateCustomersView(nil);
end;

procedure TFMXMainFrm.OrdersMenuItemClick(Sender: TObject);
begin
  CurrentView := FController.CreateOrdersView(nil);
end;

procedure TFMXMainFrm.SetCurrentView(const Value: IView);
begin
  FCurrentView := Value;
  if Assigned(FCurrentView) then
    FCurrentView.RefreshView;
end;

procedure TFMXMainFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TFMXMainFrm.DisplayEmbeddedView(const AView: IView);
begin
(*
  if Assigned(FCurrentView) then
  begin
    (FCurrentView as TForm).Free;
    CurrentView := nil;
  end;
  var LForm := AView as TForm;
  LForm.Parent := ClientPanel;
  LForm.Align := alClient;
  LForm.BorderIcons := [];
  LForm.BorderStyle := bsNone;
  LForm.Show;
  CurrentView := AView;
*)
end;

procedure TFMXMainFrm.RefreshView;
begin
  if Assigned(FCurrentView) then
    FCurrentView.RefreshView;
end;

end.
