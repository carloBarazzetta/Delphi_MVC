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
program VCLAppIO;

uses
  Vcl.Forms,
  Model in '..\Source\Model.pas',
  DataModel in '..\Source\DataModel.pas',
  Orders in '..\Source\Orders.pas',
  Order in '..\Source\Order.pas',
  Customers in '..\Source\Customers.pas',
  Customer in '..\Source\Customer.pas',
  Countries in '..\Source\Countries.pas',
  Country in '..\Source\Country.pas',
  DemoData in '..\Source\DemoData.pas',
  RandomData in '..\Source\RandomData.pas',
  AppController in '..\Source\AppController.pas',
  VCLFormViewHandler in '..\Source\VCLFormViewHandler.pas',
  VCLMainForm in '..\Source\VCLMainForm.pas' {VCLMainFrm},
  VCLOrdersForm in '..\Source\VCLOrdersForm.pas' {VCLOrdersFrm},
  VCLCustomersForm in '..\Source\VCLCustomersForm.pas' {VCLCustomersFrm};

{$R *.res}
{$R *.mdr} {Order, Customer, Country}

var
  Model: TDataModel;
  Controller: TAppController;

begin
{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Model := TDataModel.Create;
  try
    CreateRandomData(Model, 10);
    Controller := TAppController.Create(Model);
    try
      Application.Title := Controller.AppTitle;
      Controller.StartApp(TVCLFormViewHandler.Create, Model);
    finally
      Controller.Free;
    end;
  finally
    Model.Free;
  end;

  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
end.
