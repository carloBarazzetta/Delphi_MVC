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
unit Calculator.MainForm.FMX;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts,
  Calculator.Resources,
  Calculator.Types,
  Calculator.Model,
  Calculator.Controller;

type
  TCalculatorForm = class(TForm, ICalculatorView)
    TopPanel: TLayout;
    TitleLabel: TLabel;
    MenuButton: TButton;
    DisplayPanel: TLayout;
    ExpressionLabel: TLabel;
    DisplayLabel: TLabel;
    ButtonsGridLayout: TGridLayout;
    ButtonPercent: TButton;
    ButtonCE: TButton;
    ButtonC: TButton;
    ButtonBack: TButton;
    ButtonReciprocal: TButton;
    ButtonSquare: TButton;
    ButtonSqrt: TButton;
    ButtonDivide: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ButtonMultiply: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ButtonMinus: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ButtonAdd: TButton;
    ButtonPlusMinus: TButton;
    Button0: TButton;
    ButtonDecimal: TButton;
    ButtonEqual: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonsGridLayoutResize(Sender: TObject);
    procedure DigitButtonClick(Sender: TObject);
    procedure ButtonDivideClick(Sender: TObject);
    procedure ButtonPercentClick(Sender: TObject);
    procedure ButtonCEClick(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
    procedure ButtonBackClick(Sender: TObject);
    procedure ButtonReciprocalClick(Sender: TObject);
    procedure ButtonSquareClick(Sender: TObject);
    procedure ButtonSqrtClick(Sender: TObject);
    procedure ButtonMultiplyClick(Sender: TObject);
    procedure ButtonMinusClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonEqualClick(Sender: TObject);
    procedure ButtonDecimalClick(Sender: TObject);
    procedure ButtonPlusMinusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  strict private
    //ICalculatorView interface
    FController: TCalculatorController;
    FModel: TCalculatorModel;
    procedure SetController(const AValue: TCalculatorController);
    procedure SetModel(const AValue: TCalculatorModel);
    procedure RefreshView;
  private
    procedure SetButtonsCaptions;
    procedure UpdateDisplayLabel(const AValue: string);
    procedure UpdateExpressionLabel(const AValue: string);
  public
  end;

var
  CalculatorForm: TCalculatorForm;

implementation

{$R *.fmx}

procedure TCalculatorForm.ButtonDecimalClick(Sender: TObject);
begin
  FController.CollectInput(FormatSettings.DecimalSeparator);
end;

procedure TCalculatorForm.ButtonDivideClick(Sender: TObject);
begin
  FController.ExecuteOperation(coDivide);
end;

procedure TCalculatorForm.ButtonEqualClick(Sender: TObject);
begin
  FController.ExecuteOperation(coEqual);
end;

procedure TCalculatorForm.ButtonMinusClick(Sender: TObject);
begin
  FController.ExecuteOperation(coSubtract);
end;

procedure TCalculatorForm.ButtonMultiplyClick(Sender: TObject);
begin
  FController.ExecuteOperation(coMultiply);
end;

procedure TCalculatorForm.ButtonAddClick(Sender: TObject);
begin
  FController.ExecuteOperation(coAdd);
end;

procedure TCalculatorForm.ButtonBackClick(Sender: TObject);
begin
  FController.ExecuteOperation(coBack);
end;

procedure TCalculatorForm.ButtonCClick(Sender: TObject);
begin
  FController.ExecuteOperation(coClearAll);
end;

procedure TCalculatorForm.ButtonCEClick(Sender: TObject);
begin
  FController.ExecuteOperation(coClearEntry);
end;

procedure TCalculatorForm.ButtonPercentClick(Sender: TObject);
begin
  FController.ExecuteOperation(coPercent);
end;

procedure TCalculatorForm.ButtonPlusMinusClick(Sender: TObject);
begin
  FController.ExecuteOperation(coNegate);
end;

procedure TCalculatorForm.ButtonReciprocalClick(Sender: TObject);
begin
  FController.ExecuteOperation(coReciprocal);
end;

procedure TCalculatorForm.ButtonsGridLayoutResize(Sender: TObject);
begin
  ButtonsGridLayout.ItemWidth := (ButtonsGridLayout.Width / 4)-1;
  ButtonsGridLayout.ItemHeight := (ButtonsGridLayout.Height / 6)-1;
end;

procedure TCalculatorForm.ButtonSqrtClick(Sender: TObject);
begin
  FController.ExecuteOperation(coSqrt);
end;

procedure TCalculatorForm.ButtonSquareClick(Sender: TObject);
begin
  FController.ExecuteOperation(coSquare);
end;

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
  dmResources.SaveInifile;
end;

procedure TCalculatorForm.FormCreate(Sender: TObject);
begin
  //Application Title on Caption
  Caption := Application.Title;
  SetButtonsCaptions;
  //Create the Controller
  FController := TCalculatorController.Create(Self);
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
  DisplayLabel.Text := AValue;
end;

procedure TCalculatorForm.UpdateExpressionLabel(const AValue: string);
begin
  ExpressionLabel.Text := AValue;
end;
procedure TCalculatorForm.SetButtonsCaptions;
begin
  ButtonAdd.Text        := Add_Caption;
  ButtonMinus.Text      := Subtract_Caption;
  ButtonMultiply.Text   := Multiply_Caption;
  ButtonDivide.Text     := Divide_Caption;
  ButtonSqrt.Text       := Sqrt_Caption;
  ButtonSquare.Text     := Square_Caption;
  ButtonReciprocal.Text := Reciprocal_Caption;
  ButtonPercent.Text    := Percent_Caption;
  ButtonPlusMinus.Text  := Negate_Caption;
  ButtonEqual.Text      := Equal_Caption;
  ButtonBack.Text       := Back_Caption;
  ButtonCE.Text         := ClearAll_Caption;
  ButtonC.Text          := ClearEntry_Caption;
  ButtonDecimal.Text    := FormatSettings.DecimalSeparator;
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
