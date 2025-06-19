{******************************************************************************}
{       Simple MVC: A Simple Order Manager with MVC Pattern (VCL+FMX+Console)  }
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
  , Orders
  ;

type
  TVCLFormViewHandler = class(TInterfacedObject, IViewHandler)
    function CreateMainView(Model: TOrders; Controller: TAppController): IView;
    procedure ShowMainView(mainView: IView);
    function YesNo(const AQuestion: string): Boolean;
  end;

implementation

uses
  WinApi.Windows
  , Vcl.Forms
  , VCLMainForm;

{ VCLFormViewHandler }

function TVCLFormViewHandler.CreateMainView(Model: TOrders;
  Controller: TAppController): IView;
var
  VCLMainFrm: TVCLMainFrm;
begin
  Application.CreateForm(TVCLMainFrm, VCLMainFrm);
  Result := VCLMainFrm;
  Result.SetModel(Model);
  Result.SetController(Controller);
end;

procedure TVCLFormViewHandler.ShowMainView(mainView: IView);
begin
  mainView.RefreshView;
  Application.Run; //Show the main form
end;

function TVCLFormViewHandler.YesNo(const AQuestion: string): Boolean;
begin
  Result := Application.MessageBox(PChar(AQuestion), 'Question', MB_YESNO or MB_ICONQUESTION) = IDYES;
end;

end.
