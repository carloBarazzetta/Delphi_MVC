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
unit VCLMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.NumberBox,
  AppController, Model, Orders, Vcl.Menus, Vcl.ExtCtrls;

type
  TVCLMainFrm = class(TForm, IInterface, IContainerView)
    MainMenu: TMainMenu;
    DataMenuItem: TMenuItem;
    OrdersMenuItem: TMenuItem;
    CustomersMenuItem: TMenuItem;
    CountriesMenuItem: TMenuItem;
    ClientPanel: TPanel;
    procedure OrdersMenuItemClick(Sender: TObject);
    procedure CustomersMenuItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
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

{$R *.dfm}

uses Order
  , System.Generics.Collections
  , VCLOrdersForm
  , VCLCustomersForm
  ;

{ TVCLMainFrm }

procedure TVCLMainFrm.CountriesMenuItemClick(Sender: TObject);
begin
  CurrentView := FController.CreateCountriesView(Self);
end;

procedure TVCLMainFrm.CustomersMenuItemClick(Sender: TObject);
begin
  CurrentView := FController.CreateCustomersView(Self);
end;

procedure TVCLMainFrm.OrdersMenuItemClick(Sender: TObject);
begin
  CurrentView := FController.CreateOrdersView(Self);
end;

procedure TVCLMainFrm.SetCurrentView(const Value: IView);
begin
  FCurrentView := Value;
end;

procedure TVCLMainFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TVCLMainFrm.DisplayEmbeddedView(const AView: IView);
begin
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
end;

procedure TVCLMainFrm.FormActivate(Sender: TObject);
begin
  RefreshView;
end;

procedure TVCLMainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CurrentView := nil;
end;

procedure TVCLMainFrm.RefreshView;
begin
  if Assigned(FCurrentView) then
    FCurrentView.RefreshView;
end;

end.
