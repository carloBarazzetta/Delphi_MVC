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
program ConsoleApp;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Orders in '..\Source\Orders.pas',
  Order in '..\Source\Order.pas',
  AppController in '..\Source\AppController.pas',
  ConsoleViewHandler in '..\Source\ConsoleViewHandler.pas',
  ConsoleMainView in '..\Source\ConsoleMainView.pas';

var
  Model: TOrders;
  Controller: TAppController;

begin
{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Model := TOrders.Create;
  try
    try
      Controller := TAppController.Create;
      try
        Controller.StartApp(TConsoleViewHandler.Create, Model);
      finally
        Controller.Free;
      end;
    finally
      Model.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
