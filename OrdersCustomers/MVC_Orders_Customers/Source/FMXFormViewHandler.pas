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
unit FMXFormViewHandler;

interface

uses
  AppController
  , Model
  , Customer
  ;

type
  TFMXFormViewHandler = class(TInterfacedObject, IViewHandler)
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
  Fmx.Forms
  , FMXMainForm 
  , FMXCustomersForm
  , FMXOrdersForm
  , Fmx.DialogService
  , System.UITypes
  , System.SysUtils
  ;

{ FMXFormViewHandler }

function TFMXFormViewHandler.CreateMainView(const AModel: TModel;
  const AController: TAppController): IContainerView;
begin
  Application.MainForm := TFMXMainFrm.Create(Application);
  Application.MainForm.Visible := True;
  Result := Application.MainForm as TFMXMainFrm;
  Result.SetModelAndController(AModel, AController);
  Application.Run; //Show the main form
end;

function TFMXFormViewHandler.CreateOrdersView(const AModel: TModel;
  const AController: TAppController;
  const AContainer: IContainerView = nil): IOrdersView;
var
  FMXOrdersFrm: TFMXOrdersFrm;
begin
  FMXOrdersFrm := TFMXOrdersFrm.Create(Application);
  Result := FMXOrdersFrm;
  Result.SetModelAndController(AModel, AController);
  if Assigned(AContainer) then
    AContainer.DisplayEmbeddedView(Result);
end;
    
procedure TFMXFormViewHandler.RefreshCurrentView;
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

procedure TFMXFormViewHandler.ApplyFilter(const AView: IView;
  const AFilter: IApplyFilter);
begin
  ;
end;

function TFMXFormViewHandler.CreateCustomersView(const AModel: TModel;
  const AController: TAppController;
  const AContainer: IContainerView = nil): ICustomersView;
var
  FMXCustomersFrm: TFMXCustomersFrm;
begin
  FMXCustomersFrm := TFMXCustomersFrm.Create(Application);
  Result := FMXCustomersFrm;
  Result.SetModelAndController(AModel, AController);
  if Assigned(AContainer) then
    AContainer.DisplayEmbeddedView(Result);
end;

function TFMXFormViewHandler.YesNo(const AQuestion: string): Boolean;
var
  LAnswer: Boolean;
begin
  TDialogService.MessageDialog(
    AQuestion,
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbNo,
    0,
    procedure(const AResult: TModalResult)
    begin
      LAnswer := AResult = mrYes;
    end
    );
  Result := LAnswer;
end;

end.
