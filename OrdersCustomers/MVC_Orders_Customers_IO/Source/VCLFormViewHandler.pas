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
unit VCLFormViewHandler;

interface

uses
  AppController
  , Model
  , Customer
  ;

type
  TVCLFormViewHandler = class(TInterfacedObject, IViewHandler)
  strict private
    function CreateMainView(const AModel: TModel;
      const AController: TAppController): IContainerView;
    function CreateCustomersView(const AModel: TModel;
      const AController: TAppController;
      const AContainer: IContainerView = nil): ICustomersView;
    function CreateOrdersView(const AModel: TModel;
      const AController: TAppController;
      const AContainer: IContainerView = nil): IOrdersView;
    procedure ApplyFilter(const AView: IView; const AFilter: IApplyFilter);
    procedure RefreshCurrentView;
    function YesNo(const AQuestion: string): Boolean;
  end;

implementation

uses
  System.SysUtils
  , WinApi.Windows
  , Vcl.Forms
  , VCLMainForm
  , VCLCustomersForm
  , VCLOrdersForm
  ;

{ VCLFormViewHandler }

function TVCLFormViewHandler.CreateMainView(const AModel: TModel;
  const AController: TAppController): IContainerView;
var
  VCLMainFrm: TVCLMainFrm;
begin
  Application.CreateForm(TVCLMainFrm, VCLMainFrm);
  Result := VCLMainFrm;
  Result.SetModelAndController(AModel, AController);
  Application.Run; //Show the main form
end;

function TVCLFormViewHandler.CreateOrdersView(const AModel: TModel;
  const AController: TAppController;
  const AContainer: IContainerView = nil): IOrdersView;
var
  VCLOrdersFrm: TVCLOrdersFrm;
begin
  Application.CreateForm(TVCLOrdersFrm, VCLOrdersFrm);
  Result := VCLOrdersFrm;
  Result.SetModelAndController(AModel, AController);
  if Assigned(AContainer) then
    AContainer.DisplayEmbeddedView(Result);
end;

procedure TVCLFormViewHandler.RefreshCurrentView;
var
  LContainerView: IContainerView;
  LOrdersView: IOrdersView;
  LCustomersView: ICustomersView;
begin
  if Supports(Screen.ActiveForm, IOrdersView, LOrdersView) then
    LOrdersView.RefreshView;
  if Supports(Screen.ActiveForm, ICustomersView, LCustomersView) then
    LCustomersView.RefreshView;
  if Supports(Screen.ActiveForm, IContainerView, LContainerView) then
    LContainerView.RefreshView;
end;

procedure TVCLFormViewHandler.ApplyFilter(const AView: IView;
  const AFilter: IApplyFilter);
begin
  ;
end;

function TVCLFormViewHandler.CreateCustomersView(const AModel: TModel;
  const AController: TAppController;
  const AContainer: IContainerView = nil): ICustomersView;
var
  VCLCustomersFrm: TVCLCustomersFrm;
begin
  Application.CreateForm(TVCLCustomersFrm, VCLCustomersFrm);
  Result := VCLCustomersFrm;
  Result.SetModelAndController(AModel, AController);
  if Assigned(AContainer) then
    AContainer.DisplayEmbeddedView(Result);
end;

function TVCLFormViewHandler.YesNo(const AQuestion: string): Boolean;
begin
  Result := Application.MessageBox(PChar(AQuestion), 'Question', MB_YESNO or MB_ICONQUESTION) = IDYES;
end;

end.
