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
program FMXApp;

uses
  FMX.Forms,
  Model in '..\Source\Model.pas',
  Orders in '..\Source\Orders.pas',
  Order in '..\Source\Order.pas',
  Customers in '..\Source\Customers.pas',
  Customer in '..\Source\Customer.pas',
  Countries in '..\Source\Countries.pas',
  Country in '..\Source\Country.pas',
  DemoData in '..\Source\DemoData.pas',
  RandomData in '..\Source\RandomData.pas',
  AppController in '..\Source\AppController.pas',
  FMXFormViewHandler in '..\Source\FMXFormViewHandler.pas',
  FMXMainForm in '..\Source\FMXMainForm.pas' {FMXMainFrm},
  FMXOrdersForm in '..\Source\FMXOrdersForm.pas' {FMXOrdersFrm},
  FMXCustomersForm in '..\Source\FMXCustomersForm.pas' {FMXCustomersFrm};

{$R *.res}

var
  Model: TModel;
  Controller: TAppController;

begin
{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Model := TModel.Create;
  try
    CreateRandomData(Model, 10);
    Controller := TAppController.Create(Model);
    try
      Application.Title := Controller.AppTitle;
      Controller.StartApp(TFMXFormViewHandler.Create, Model);
    finally
      Controller.Free;
    end;
  finally
    Model.Free;
  end;

end.
