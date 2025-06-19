{******************************************************************************}
{       Calculator Flat: An example of Calculator in VCL (no MVC Pattern       }
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
unit Calculator.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  System.Actions, Vcl.ActnList,
  Calculator.Resources,
  Calculator.Types;

type
  TCalculatorForm = class(TForm)
    TopPanel: TPanel;
    MenuButton: TButton;
    TitleLabel: TLabel;
    VirtualImageList: TVirtualImageList;
    DisplayPanel: TPanel;
    ExpressionLabel: TLabel;
    DisplayLabel: TLabel;
    ButtonsGridPanel: TGridPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button0: TButton;
    ButtonPercent: TButton;
    ButtonBlank: TButton;
    ButtonClearAll: TButton;
    ButtonBack: TButton;
    ButtonReciprocal: TButton;
    ButtonSquare: TButton;
    ButtonSqrt: TButton;
    ButtonDivide: TButton;
    ButtonMultiply: TButton;
    ButtonMinus: TButton;
    ButtonAdd: TButton;
    ButtonPlusMinus: TButton;
    ButtonDecimal: TButton;
    ButtonEqual: TButton;
    ActionList: TActionList;
    AddAction: TAction;
    SubtractAction: TAction;
    BackAction: TAction;
    ClearAllAction: TAction;
    MultiplyAction: TAction;
    DivideAction: TAction;
    EqualAction: TAction;
    SqrtAction: TAction;
    NegateAction: TAction;
    PercentAction: TAction;
    ReciprocalAction: TAction;
    SquareAction: TAction;
    DecimalSepAction: TAction;
    DigitAction: TAction;
    ClearEntryAction: TAction;
    procedure FormCreate(Sender: TObject);

    procedure DigitButtonClick(Sender: TObject);

    procedure AddActionExecute(Sender: TObject);
    procedure SubtractActionExecute(Sender: TObject);
    procedure BackActionExecute(Sender: TObject);
    procedure ClearAllActionExecute(Sender: TObject);
    procedure MultiplyActionExecute(Sender: TObject);
    procedure DivideActionExecute(Sender: TObject);
    procedure EqualActionExecute(Sender: TObject);
    procedure SqrtActionExecute(Sender: TObject);
    procedure NegateActionExecute(Sender: TObject);
    procedure PercentActionExecute(Sender: TObject);
    procedure SquareActionExecute(Sender: TObject);
    procedure DecimalSepActionExecute(Sender: TObject);
    procedure ClearEntryActionExecute(Sender: TObject);
    procedure ReciprocalActionExecute(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
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

    procedure ClearAll;
    procedure ClearEntry;
    procedure Backspace;
    procedure ExecuteOperation(const AOperation: TCalcOperation);
    function CalculateOperation(const AOperation: TOperatorType; const A, B: Double): Double;
    procedure CalculatePendingOperation;
    procedure InputUnaryOperator(const AOperation: TOperatorType);
    procedure InputBinaryOperator(const AOperation: TOperatorType);
    procedure CollectInput(const AValue: Char);
    procedure EvaluateResult;
    procedure SetActionCaptions;
    procedure SetTotalValue(const Value: Double);
    procedure SetCurrentValue(const Value: Double);
    procedure PressKeyButton(const Key: Char);
    procedure UpdateDisplayLabel(const AValue: string);
    procedure UpdateExpressionLabel(const AValue: string);
    procedure CalcExpressionText(const AOperation: TCalcOperation;
      const AOldInput: string);
    function GetCurrentValueStr: string;
    function GetTotalValueStr: string;
  public
    //Exception Handler
    procedure OnException(Sender: TObject; E: Exception);

    //Properties
    property CurrentInput: string read FCurrentInput write SetCurrentInput;
    property CurrentValue: Double read FCurrentValue write SetCurrentValue;
    property TotalValue: Double read FTotalValue write SetTotalValue;
    property Expression: string read FExpression write SetExpression;
    property CurrentValueStr: string read GetCurrentValueStr;
    property TotalValueStr: string read GetTotalValueStr;
  end;

var
  CalculatorForm: TCalculatorForm;

implementation

{$R *.dfm}

uses
  Vcl.Themes;

procedure TCalculatorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmResources.MainFormPos_Top := Self.Top;
  dmResources.MainFormPos_Left := Self.Left;
  dmResources.MainFormPos_Width := Self.Width;
  dmResources.MainFormPos_Height := Self.Height;
  dmResources.Application_Theme := TStyleManager.ActiveStyle.Name;
  dmResources.SaveInifile;
end;

procedure TCalculatorForm.FormCreate(Sender: TObject);
begin
  //Apply application Style
  TStyleManager.TrySetStyle(dmResources.Application_Theme);
  //Application Title on Caption
  Caption := Application.Title;
  SetActionCaptions;
  //Initialization of Calculator
  ClearAll;
end;

procedure TCalculatorForm.OnException(Sender: TObject; E: Exception);
begin
  if E is ECalculatorException then
    UpdateDisplayLabel(E.Message)
  else
    UpdateDisplayLabel(UNEXPECTED_ERROR);
  ExecuteOperation(coClearEntry);
end;

procedure TCalculatorForm.ClearAllActionExecute(Sender: TObject);
begin
  ExecuteOperation(coClearAll);
end;

procedure TCalculatorForm.BackActionExecute(Sender: TObject);
begin
  ExecuteOperation(coBack);
end;

procedure TCalculatorForm.SqrtActionExecute(Sender: TObject);
begin
  ExecuteOperation(coSqrt);
end;

procedure TCalculatorForm.SquareActionExecute(Sender: TObject);
begin
  ExecuteOperation(coSquare);
end;

procedure TCalculatorForm.DecimalSepActionExecute(Sender: TObject);
begin
  CollectInput(FormatSettings.DecimalSeparator);
end;

procedure TCalculatorForm.SubtractActionExecute(Sender: TObject);
begin
  ExecuteOperation(coSubtract);
end;

procedure TCalculatorForm.PercentActionExecute(Sender: TObject);
begin
  ExecuteOperation(coPercent);
end;

procedure TCalculatorForm.AddActionExecute(Sender: TObject);
begin
  ExecuteOperation(coAdd);
end;

procedure TCalculatorForm.NegateActionExecute(Sender: TObject);
begin
  ExecuteOperation(coNegate);
end;

procedure TCalculatorForm.MultiplyActionExecute(Sender: TObject);
begin
  ExecuteOperation(coMultiply);
end;

procedure TCalculatorForm.DivideActionExecute(Sender: TObject);
begin
  ExecuteOperation(coDivide);
end;

procedure TCalculatorForm.EqualActionExecute(Sender: TObject);
begin
  ExecuteOperation(coEqual);
end;

procedure TCalculatorForm.ClearEntryActionExecute(Sender: TObject);
begin
  ExecuteOperation(coClearEntry);
end;

procedure TCalculatorForm.ReciprocalActionExecute(Sender: TObject);
begin
  ExecuteOperation(coReciprocal);
end;

procedure TCalculatorForm.DigitButtonClick(Sender: TObject);
begin
  var LDigit := (Sender as TButton).Tag;
  CollectInput(Char(Ord('0') + LDigit));
end;

procedure TCalculatorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    ExecuteOperation(coEqual)
  else if Key = VK_BACK then
    ExecuteOperation(coBack)
  else if Key = VK_ESCAPE then
    ExecuteOperation(coClearAll)
end;

procedure TCalculatorForm.PressKeyButton(const Key: Char);
var
  LButton: TButton;
begin
  //Feedback of Button Pressed
  if (Key = '*') then
    LButton := ButtonMultiply
  else if (Key = ',') then
    LButton := ButtonDecimal
  else if (Key = '-') then
    LButton := ButtonMinus
  else if (Key = '+') then
    LButton := ButtonAdd
  else if (Key = '/') then
    LButton := ButtonDivide
  else if (Key = '=') then
    LButton := ButtonEqual
  else if (Key = 'C') then
    LButton := ButtonClearAll
  else if (Key = '%') then
    LButton := ButtonPercent
  else
    LButton := FindComponent('Button'+Key) as TButton;
  if not Assigned(LButton) then
    Exit;

  // Save current focus
  var LPreviousFocus := Self.ActiveControl;

  // Simulate mouse down
  SendMessage(LButton.Handle, WM_LBUTTONDOWN, MK_LBUTTON, 0);
  Application.ProcessMessages;

  // Little pause to show click effect
  Sleep(50);

  // Simulate mouse up (that call the method Click)
  SendMessage(LButton.Handle, WM_LBUTTONUP, 0, 0);
  Application.ProcessMessages;

  // Save current focus
  if Assigned(LPreviousFocus) then
    LPreviousFocus.SetFocus;
end;

procedure TCalculatorForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key,['0'..'9']) //Numbers from 0 to 9
    or (Key = FormatSettings.DecimalSeparator) //DecimalSeparator
    or CharInSet(Key, ['*','-','+','/','=','C','%']) //Other Buttons
    then PressKeyButton(Key);
end;

procedure TCalculatorForm.FormShow(Sender: TObject);
begin
  //Form position based on values read from .ini file
  SetBounds(
    dmResources.MainFormPos_Left,
    dmResources.MainFormPos_Top,
    dmResources.MainFormPos_Width,
    dmResources.MainFormPos_Height);
end;

procedure TCalculatorForm.UpdateDisplayLabel(const AValue: string);
begin
  DisplayLabel.Caption := AValue;
end;

procedure TCalculatorForm.UpdateExpressionLabel(const AValue: string);
begin
  ExpressionLabel.Caption := AValue;
end;

procedure TCalculatorForm.SetActionCaptions;
begin
  AddAction.Caption        := Add_Caption;
  SubtractAction.Caption   := Subtract_Caption;
  MultiplyAction.Caption   := Multiply_Caption;
  DivideAction.Caption     := Divide_Caption;
  SqrtAction.Caption       := Sqrt_Caption;
  SquareAction.Caption     := Square_Caption;
  ReciprocalAction.Caption := Reciprocal_Caption;
  PercentAction.Caption    := Percent_Caption;
  NegateAction.Caption     := Negate_Caption;
  EqualAction.Caption      := Equal_Caption;
  BackAction.Caption       := Back_Caption;
  ClearAllAction.Caption   := ClearAll_Caption;
  ClearEntryAction.Caption := ClearEntry_Caption;
  DecimalSepAction.Caption := FormatSettings.DecimalSeparator;
end;

function TCalculatorForm.CalculateOperation(const AOperation: TOperatorType;
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

procedure TCalculatorForm.ExecuteOperation(const AOperation: TCalcOperation);
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

procedure TCalculatorForm.CalculatePendingOperation;
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

function TCalculatorForm.GetCurrentValueStr: string;
begin
  Result := FloatToStr(FCurrentValue, FormatSettings);
end;

function TCalculatorForm.GetTotalValueStr: string;
begin
  Result := FloatToStr(FTotalValue, FormatSettings);
end;

procedure TCalculatorForm.CalcExpressionText(
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

procedure TCalculatorForm.SetCurrentInput(const AValue: string);
begin
  //Aggiorna la variabile stringa
  if (FCurrentInput <> AValue) and (AValue <> '') then
  begin
    FCurrentInput := AValue;

    //Aggiorna FCurrentValue
    CurrentValue := StrToFloat(FCurrentInput, FormatSettings);
  end;
  //Aggiorna la GUI per mostrare il valore
  UpdateDisplayLabel(CurrentInput);
end;

procedure TCalculatorForm.SetCurrentValue(const Value: Double);
begin
  FCurrentValue := Value;
end;

procedure TCalculatorForm.SetExpression(const AValue: string);
begin
  //Update Internal Value
  FExpression := AValue;
  //Update GUI for Expression
  UpdateExpressionLabel(FExpression);
end;

procedure TCalculatorForm.SetTotalValue(const Value: Double);
begin
  FTotalValue := Value;
end;

procedure TCalculatorForm.EvaluateResult;
begin
  if FPendingOperator <> opNone then
  begin
    CalculatePendingOperation;
    FPendingOperator := opNone;
    FResetInput := True;
  end;
end;

procedure TCalculatorForm.ClearAll;
begin
  CurrentInput := '0';
  Expression := '';
  FTotalValue := 0;
  FPendingOperator := opNone;
  FResetInput := True;
end;

procedure TCalculatorForm.ClearEntry;
begin
  // Clears current number entry only
  CurrentValue := 0;
  FResetInput := True;
end;

procedure TCalculatorForm.CollectInput(const AValue: Char);
begin
  if AValue = FormatSettings.DecimalSeparator then
  begin
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
    if CharInSet(AValue, ['0'..'9']) then
    begin
      if FResetInput or (FCurrentInput = '0') then
      begin
        CurrentInput := AValue;
        FResetInput := False;
      end
      else
        CurrentInput := FCurrentInput + AValue;
    end;
  end;
end;

procedure TCalculatorForm.InputBinaryOperator(const AOperation: TOperatorType);
begin
  if FPendingOperator <> opNone then
    FTotalValue := CalculateOperation(FPendingOperator, FTotalValue, FCurrentValue)
  else
    FTotalValue := FCurrentValue;

  FPendingOperator := AOperation;
  FResetInput := True;
end;

procedure TCalculatorForm.InputUnaryOperator(const AOperation: TOperatorType);
begin
  CurrentValue := CalculateOperation(AOperation, FCurrentValue, 0);
  CurrentInput := FloatToStr(FCurrentValue);
  FPendingOperator := opNone;
  FResetInput := True;
end;

procedure TCalculatorForm.Backspace;
begin
  if (Length(FCurrentInput) > 1) then
    CurrentInput := Copy(FCurrentInput, 1, Length(FCurrentInput) - 1)
  else
    CurrentInput := '0';
end;

end.
