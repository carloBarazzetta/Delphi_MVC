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
unit Calculator.Controller;

interface

uses
  Calculator.Types
  , Calculator.Model
  ;

type
  TCalculatorController = class;

  ICalculatorView = interface(IInterface)
    ['{944A4560-6DC6-4ADC-B7E9-84DBFA3CA5A4}']
    procedure SetController(const AValue: TCalculatorController);
    procedure SetModel(const AValue: TCalculatorModel);
    procedure RefreshView;
  end;

  TCalculatorController = class
  private
    FModel: TCalculatorModel;
    FMainView: ICalculatorView;
  public
    constructor Create(const AView: ICalculatorView);
    //Controller Calculator Operation called by View
    procedure ExecuteOperation(const AOperation: TCalcOperation);
    //Aquire Input
    procedure CollectInput(const AValue: Char);
  end;

implementation

uses
  System.SysUtils
  , Calculator.Resources
  ;

{ TCalculatorController }

procedure TCalculatorController.CollectInput(const AValue: Char);
begin
  FModel.InputDigitOrDecimalSep(AValue);
  FMainView.RefreshView;
end;

constructor TCalculatorController.Create(const AView: ICalculatorView);
begin
  inherited Create;
  //Initialization of Model/View/Controller structure
  FMainView := AView;
  FModel := TCalculatorModel.Create;
  FMainView.SetModel(FModel);
  FMainView.SetController(Self);
  FMainView.RefreshView;
end;

procedure TCalculatorController.ExecuteOperation(const AOperation: TCalcOperation);
begin
  FModel.ExecuteOperation(AOperation);
  FMainView.RefreshView;
end;

end.
