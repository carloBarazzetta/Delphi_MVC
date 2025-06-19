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
unit Calculator.Engine;

interface

uses
  Calculator.Types
  ;

type
  TCalcEngine = class
  private
    FCurrentValue: Double;         // Number shown on screen
    FStoredValue: Double;          // Stored operand
    FPendingOperator: TOperatorType; // Waiting operator
    FIsNewInput: Boolean;
    function ExecuteOperation(Op: TOperatorType; A, B: Double): Double;          // Whether we're starting new number input
  public
    constructor Create;
    procedure ClearAll;
    procedure ClearEntry;
    procedure Backspace;
    procedure InputDigit(const D: Char);
    procedure InputDecimalSeparator;
    procedure InputUnaryOperator(const Op: TOperatorType);
    procedure InputBinaryOperator(const Op: TOperatorType);
    procedure InputEqual;
    function GetDisplay: String;
  end;

implementation

uses
  System.SysUtils
  ;

function TCalcEngine.ExecuteOperation(Op: TOperatorType; A, B: Double): Double;
begin
  case Op of
    opAdd:        Result := A + B;
    opSubtract:   Result := A - B;
    opMultiply:   Result := A * B;
    opDivide:     if B <> 0 then Result := A / B else raise Exception.Create('Division by zero');
    opPercent:    Result := A * (B / 100); // B è la % di A
    opSqrt:       if A >= 0 then Result := Sqrt(A) else raise Exception.Create('Invalid sqrt');
    opSquare:     Result := Sqr(A);
    opReciprocal: if A <> 0 then Result := 1 / A else raise Exception.Create('Division by zero');
    opNegate:     Result := -A;
    else
      Result := B;
  end;
end;

constructor TCalcEngine.Create;
begin
  ClearAll;
end;

procedure TCalcEngine.ClearAll;
begin
  FCurrentValue := 0;
  FStoredValue := 0;
  FPendingOperator := opNone;
  FIsNewInput := True;
end;

procedure TCalcEngine.ClearEntry;
begin
  // Clears current number entry only
  FCurrentValue := 0;
  FIsNewInput := True;
end;

procedure TCalcEngine.InputDecimalSeparator;
begin
  ;
end;

procedure TCalcEngine.InputDigit(const D: Char);
begin
  if not CharInSet(D, ['0'..'9']) then
    Exit;

  if FIsNewInput then
  begin
    FCurrentValue := 0;
    FIsNewInput := False;
  end;

  // Build number as text and convert back to float
  var S := FloatToStr(FCurrentValue, FormatSettings);
  if S = '0' then
    S := D
  else
    S := S + D;

  FCurrentValue := StrToFloat(S, FormatSettings);
end;

procedure TCalcEngine.InputBinaryOperator(const Op: TOperatorType);
begin
  if FPendingOperator <> opNone then
    FStoredValue := ExecuteOperation(FPendingOperator, FStoredValue, FCurrentValue)
  else
    FStoredValue := FCurrentValue;

  FPendingOperator := Op;
  FIsNewInput := True;
end;

procedure TCalcEngine.InputUnaryOperator(const Op: TOperatorType);
begin
  FCurrentValue := ExecuteOperation(Op, FCurrentValue, 0);
end;

procedure TCalcEngine.InputEqual;
begin
  if FPendingOperator <> opNone then
  begin
    FCurrentValue := ExecuteOperation(FPendingOperator, FStoredValue, FCurrentValue);
    FPendingOperator := opNone;
    FIsNewInput := True;
  end;
end;

procedure TCalcEngine.Backspace;
var
  S: String;
begin
  S := FloatToStr(FCurrentValue, FormatSettings);
  if Length(S) > 1 then
    Delete(S, Length(S), 1)
  else
    S := '0';

  FCurrentValue := StrToFloat(S, FormatSettings);
end;

function TCalcEngine.GetDisplay: String;
begin
  Result := FloatToStr(FCurrentValue, FormatSettings);
end;

end.
