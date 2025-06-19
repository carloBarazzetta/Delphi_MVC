{******************************************************************************}
{       Calculator MVC: An example of Calculator with MVC Pattern (VCL+FMX)    }
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
unit Calculator.Resources;

uses
  System.StartUpCopy,
  FMX.Forms,
  Calculator.Types in '..\Sources\Calculator.Types.pas',
  Calculator.Model in '..\Sources\Calculator.Model.pas',
  Calculator.Controller in '..\Sources\Calculator.Controller.pas',
  Calculator.MainForm.FMX in '..\Sources\Calculator.MainForm.FMX.pas' {CalculatorForm},
  Calculator.Resources in '..\Sources\Calculator.Resources.pas' {dmResources: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Calculator - Copyright (c) 2024-2025 Ethea S.r.l.';
  //Create datamodule of resources
  Application.CreateForm(TdmResources, dmResources);
  //Create Main Form
  Application.CreateForm(TCalculatorForm, CalculatorForm);
  Application.Run;
end.
