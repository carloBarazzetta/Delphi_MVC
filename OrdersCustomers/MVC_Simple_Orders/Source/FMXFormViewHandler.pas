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
unit FMXFormViewHandler;

interface

uses AppController, Orders;

type
  TFMXFormViewHandler = class(TInterfacedObject, IViewHandler)
  public
    function CreateMainView(Model: TOrders; Controller: TAppController): IView;
    procedure ShowMainView(mainView: IView);
    function YesNo(const AQuestion: string): Boolean;
  end;

implementation

uses Fmx.Forms, FMXMainForm, Fmx.DialogService, System.UITypes;

{ FMXFormViewHandler }

function TFMXFormViewHandler.CreateMainView(Model: TOrders;
  Controller: TAppController): IView;
begin
  Application.MainForm := TFMXMainFrm.Create(Application);
  Application.MainForm.Visible := True;
  Result := Application.MainForm as TFMXMainFrm;
  Result.SetModel(Model);
  Result.SetController(Controller);
end;

procedure TFMXFormViewHandler.ShowMainView(mainView: IView);
begin
  mainView.RefreshView;
  Application.Run;
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
