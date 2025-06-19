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
unit Calculator.Model;

interface

uses
  Calculator.Types
  ;

type
  TCalculatorModel = class
  private
    FCurrentInput: string; // Number shown on screen
    FCurrentValue: Double; // Current Value of Number on string
    FTotalValue: Double; // Stored Total Value
    FPendingOperator: TOperatorType; // Waiting operator
    FResetInput: Boolean;
    FExpression: string;

    //Setter properties
    procedure SetCurrentInput(const AValue: string);
    procedure SetExpression(const AValue: string);

    procedure Backspace;
    function CalculateOperation(const AOperation: TOperatorType; const A, B: Double): Double;
    procedure CalculatePendingOperation;
    procedure InputUnaryOperator(const AOperation: TOperatorType);
    procedure InputBinaryOperator(const AOperation: TOperatorType);

    procedure SetCurrentValue(const Value: Double);
    function GetCurrentValueStr: string;
    function GetTotalValueStr: string;
    procedure ClearAll;
    procedure ClearEntry;
    procedure EvaluateResult;
    procedure CalcExpressionText(const AOperation: TCalcOperation;
      const AOldInput: string);

    property CurrentValue: Double read FCurrentValue write SetCurrentValue;
    property Expression: string read FExpression write SetExpression;
    property CurrentValueStr: string read GetCurrentValueStr;
    property TotalValueStr: string read GetTotalValueStr;
    property CurrentInput: string read FCurrentInput write SetCurrentInput;
  public
    constructor Create;
    procedure ExecuteOperation(const AOperation: TCalcOperation);
    procedure InputDigitOrDecimalSep(const AValue: Char);
    procedure GetDisplayValues(out ACurrentInput, AExpression: string);
  end;

implementation

uses
  System.SysUtils
  , Calculator.Resources
  ;

function TCalculatorModel.CalculateOperation(const AOperation: TOperatorType;
  const A, B: Double): Double;
begin
  case AOperation of
    opAdd: Result := A + B;
    opSubtract: Result := A - B;
    opMultiply: Result := A * B;
    opDivide:
      if B <> 0 then
        Result := A / B
      else
        raise ECalculatorException.Create(DIVISION_BY_ZERO);
    opPercent: Result := (A / 100);
    opSqrt:
      if A >= 0 then
        Result := Sqrt(A)
      else
        raise ECalculatorException.Create(INVALID_SQUARE_ROOT);
    opSquare: Result := Sqr(A);
    opReciprocal:
      if A <> 0 then
        Result := 1 / A
      else
        raise ECalculatorException.Create(DIVISION_BY_ZERO);
    opNegate: Result := -A;
  else
    Result := B;
  end;
end;

procedure TCalculatorModel.ExecuteOperation(const AOperation: TCalcOperation);
begin
  var LCurrentInput := CurrentInput;
  case AOperation of
    //Binary Operations
    coAdd: InputBinaryOperator(opAdd);
    coSubtract: InputBinaryOperator(opSubtract);
    coMultiply: InputBinaryOperator(opMultiply);
    coDivide: InputBinaryOperator(opDivide);
    //Unary Operations
    coSqrt: InputUnaryOperator(opSqrt);
    coSquare: InputUnaryOperator(opSquare);
    coReciprocal: InputUnaryOperator(opReciprocal);
    coPercent: InputUnaryOperator(opPercent);
    coNegate: InputUnaryOperator(opNegate);
    //Other Operations
    coEqual: EvaluateResult;
    coBack: Backspace;
    coClearAll: ClearAll;
    coClearEntry: ClearEntry;
  end;
  CalcExpressionText(AOperation, LCurrentInput);
end;

procedure TCalculatorModel.CalculatePendingOperation;
begin
  case FPendingOperator of
    opAdd: FTotalValue := FTotalValue + FCurrentValue;
    opSubtract: FTotalValue := FTotalValue - FCurrentValue;
    opMultiply: FTotalValue := FTotalValue * FCurrentValue;
    opDivide:
      if FCurrentValue <> 0 then
        FTotalValue := FTotalValue / FCurrentValue
      else
        raise ECalculatorException.Create(DIVISION_BY_ZERO);
  end;
  CurrentInput := FloatToStr(FTotalValue);
end;

constructor TCalculatorModel.Create;
begin
  //Initialization of Calculator
  ClearAll;
end;

function TCalculatorModel.GetCurrentValueStr: string;
begin
  Result := FloatToStr(FCurrentValue, FormatSettings);
end;

procedure TCalculatorModel.GetDisplayValues(out ACurrentInput,
  AExpression: string);
begin
  ACurrentInput := FCurrentInput;
  AExpression := FExpression;
end;

function TCalculatorModel.GetTotalValueStr: string;
begin
  Result := FloatToStr(FTotalValue, FormatSettings);
end;

procedure TCalculatorModel.CalcExpressionText(
  const AOperation: TCalcOperation;
  const AOldInput: string);
begin
  case AOperation of
    //Binary Operation
    coAdd, coSubtract, coMultiply, coDivide:
    begin
      Expression := Format('%s %s',
        [TotalValueStr, TCalcOperationCaption[AOperation]]);
    end;
    //Unary Operation
    coSqrt, coSquare, coReciprocal, coPercent, coNegate:
    begin
      Expression := Format('%s(%s)',
        [TCalcOperationCaption[AOperation], AOldInput]);
    end;
    coEqual:
    begin
      Expression := Format('%s %s %s',
        [Expression, AOldInput, TCalcOperationCaption[AOperation]]);
    end;
    coBack:
    begin
      //TODO
    end;
    coClearAll: Expression := '';
  end;
end;

procedure TCalculatorModel.SetCurrentInput(const AValue: string);
begin
  //Aggiorna la variabile stringa
  if (FCurrentInput <> AValue) and (AValue <> '') then
  begin
    FCurrentInput := AValue;

    //Aggiorna FCurrentValue
    CurrentValue := StrToFloat(FCurrentInput, FormatSettings);
  end;
end;

procedure TCalculatorModel.SetCurrentValue(const Value: Double);
begin
  FCurrentValue := Value;
end;

procedure TCalculatorModel.SetExpression(const AValue: string);
begin
  //Update Expression Value
  FExpression := AValue;
end;

procedure TCalculatorModel.EvaluateResult;
begin
  if FPendingOperator <> opNone then
  begin
    CalculatePendingOperation;
    FPendingOperator := opNone;
    FResetInput := True;
  end;
end;

procedure TCalculatorModel.ClearAll;
begin
  CurrentInput := '0';
  Expression := '';
  FTotalValue := 0;
  FPendingOperator := opNone;
  FResetInput := True;
end;

procedure TCalculatorModel.ClearEntry;
begin
  // Clears current number entry only
  CurrentValue := 0;
  FResetInput := True;
end;

procedure TCalculatorModel.InputDigitOrDecimalSep(const AValue: Char);
begin
  if AValue = FormatSettings.DecimalSeparator then
  begin
    //Input of Decimal Separator
    if FResetInput then
    begin
      CurrentInput := '0'+FormatSettings.DecimalSeparator;
      FResetInput := False;
    end
    else if Pos('.', FCurrentInput) = 0 then
      CurrentInput := FCurrentInput + FormatSettings.DecimalSeparator;
  end
  else
  begin
    //Input of a Digit (0..9)
    if FResetInput or (FCurrentInput = '0') then
    begin
      CurrentInput := AValue;
      FResetInput := False;
    end
    else
      CurrentInput := FCurrentInput + AValue;
  end;
end;

procedure TCalculatorModel.InputBinaryOperator(const AOperation: TOperatorType);
begin
  if FPendingOperator <> opNone then
    FTotalValue := CalculateOperation(FPendingOperator, FTotalValue, FCurrentValue)
  else
    FTotalValue := FCurrentValue;

  FPendingOperator := AOperation;
  FResetInput := True;
end;

procedure TCalculatorModel.InputUnaryOperator(const AOperation: TOperatorType);
begin
  CurrentValue := CalculateOperation(AOperation, FCurrentValue, 0);
  CurrentInput := CurrentValueStr;
  FPendingOperator := opNone;
  FResetInput := True;
end;

procedure TCalculatorModel.Backspace;
begin
  if (Length(FCurrentInput) > 1) then
    CurrentInput := Copy(FCurrentInput, 1, Length(FCurrentInput) - 1)
  else
    CurrentInput := '0';
end;

end.
