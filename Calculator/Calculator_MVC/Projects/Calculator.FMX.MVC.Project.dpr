program Calculator.FMX.MVC.Project;

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
