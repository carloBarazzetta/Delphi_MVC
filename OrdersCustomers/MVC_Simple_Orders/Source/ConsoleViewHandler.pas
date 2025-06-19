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
unit ConsoleViewHandler;

interface

uses
  AppController
  , Orders;

type
  TConsoleViewHandler = class(TInterfacedObject, IViewHandler)
    function CreateMainView(Model: TOrders; Controller: TAppController): IView;
    procedure ShowMainView(mainView: IView);
    function YesNo(const AQuestion: string): Boolean;
  end;

implementation

uses
  System.SysUtils
  , ConsoleMainView
  ;

{ TConsoleViewHandler }

function TConsoleViewHandler.CreateMainView(Model: TOrders;
  Controller: TAppController): IView;
begin
  Result := TConsoleMainView.Create;
  Result.SetModel(Model);
  Result.SetController(Controller);
end;

procedure TConsoleViewHandler.ShowMainView(mainView: IView);
begin
  mainView.RefreshView;
end;

function TConsoleViewHandler.YesNo(const AQuestion: string): Boolean;
var
  S: string;
begin
  System.Write(AQuestion, ' [Y|n]:');
  System.Readln(S);
  Result := SameText(S, 'y');
end;

end.
