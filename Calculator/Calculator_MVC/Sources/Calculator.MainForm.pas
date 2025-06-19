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
﻿unit Calculator.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  System.Actions, Vcl.ActnList,
  Calculator.Resources,
  Calculator.Types,
  Calculator.Model,
  Calculator.Controller;

type
  TCalculatorForm = class(TForm, ICalculatorView)
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
  strict private
    //ICalculatorView interface
    FController: TCalculatorController;
    FModel: TCalculatorModel;
    procedure SetController(const AValue: TCalculatorController);
    procedure SetModel(const AValue: TCalculatorModel);
    procedure RefreshView;
  private
    procedure SetActionCaptions;
    procedure PressKeyButton(const Key: Char);
    procedure UpdateDisplayLabel(const AValue: string);
    procedure UpdateExpressionLabel(const AValue: string);
  public
    //Exception Handler
    procedure OnException(Sender: TObject; E: Exception);

  end;

var
  CalculatorForm: TCalculatorForm;

implementation

{$R *.dfm}

uses
  Vcl.Themes;


procedure TCalculatorForm.DigitButtonClick(Sender: TObject);
begin
  var LDigit: Integer := (Sender as TButton).Tag;
  var LKey: Char := Char(Ord('0') + LDigit);
  FController.CollectInput(LKey);
end;

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
  //Create the Controller
  FController := TCalculatorController.Create(Self);
end;

procedure TCalculatorForm.OnException(Sender: TObject; E: Exception);
begin
  if E is ECalculatorException then
    UpdateDisplayLabel(E.Message)
  else
    UpdateDisplayLabel(UNEXPECTED_ERROR);
  FController.ExecuteOperation(coClearEntry);
end;

procedure TCalculatorForm.ClearAllActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coClearAll);
end;

procedure TCalculatorForm.BackActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coBack);
end;

procedure TCalculatorForm.SqrtActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coSqrt);
end;

procedure TCalculatorForm.SquareActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coSquare);
end;

procedure TCalculatorForm.DecimalSepActionExecute(Sender: TObject);
begin
  FController.CollectInput(FormatSettings.DecimalSeparator);
end;

procedure TCalculatorForm.SubtractActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coSubtract);
end;

procedure TCalculatorForm.PercentActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coPercent);
end;

procedure TCalculatorForm.AddActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coAdd);
end;

procedure TCalculatorForm.NegateActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coNegate);
end;

procedure TCalculatorForm.MultiplyActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coMultiply);
end;

procedure TCalculatorForm.DivideActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coDivide);
end;

procedure TCalculatorForm.EqualActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coEqual);
end;

procedure TCalculatorForm.ClearEntryActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coClearEntry);
end;

procedure TCalculatorForm.ReciprocalActionExecute(Sender: TObject);
begin
  FController.ExecuteOperation(coReciprocal);
end;

procedure TCalculatorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    FController.ExecuteOperation(coEqual)
  else if Key = VK_BACK then
    FController.ExecuteOperation(coBack)
  else if Key = VK_ESCAPE then
    FController.ExecuteOperation(coClearAll)
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

procedure TCalculatorForm.SetController(const AValue: TCalculatorController);
begin
  FController := AValue;
end;

procedure TCalculatorForm.SetModel(const AValue: TCalculatorModel);
begin
  FModel := AValue;
end;

procedure TCalculatorForm.RefreshView;
var
  LCurrentInput, LExpression: string;
begin
  FModel.GetDisplayValues(LCurrentInput, LExpression);
  UpdateDisplayLabel(LCurrentInput);
  UpdateExpressionLabel(LExpression);
end;

end.
