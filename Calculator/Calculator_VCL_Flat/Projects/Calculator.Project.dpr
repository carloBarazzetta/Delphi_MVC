program Calculator.Project;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  Calculator.Types in '..\Sources\Calculator.Types.pas',
  Calculator.MainForm in '..\Sources\Calculator.MainForm.pas' {CalculatorForm},
  Calculator.Resources in '..\Sources\Calculator.Resources.pas' {dmResources: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Calculator - Copyright (c) 2024-2025 Ethea S.r.l.';
  //Create datamodule of resources
  Application.CreateForm(TdmResources, dmResources);
  //Create Main Form
  Application.CreateForm(TCalculatorForm, CalculatorForm);
  //Use Custom Exception Handler
  Application.OnException := CalculatorForm.OnException;
  Application.Run;
end.
