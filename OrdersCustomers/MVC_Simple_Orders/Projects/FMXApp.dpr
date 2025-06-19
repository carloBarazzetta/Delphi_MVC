/// <summary>
/// FireMonkey application
/// </summary>
program FMXApp;

uses
  FMX.Forms,
  Orders in '..\Source\Orders.pas',
  Order in '..\Source\Order.pas',
  AppController in '..\Source\AppController.pas',
  FMXFormViewHandler in '..\Source\FMXFormViewHandler.pas',
  FMXMainForm in '..\Source\FMXMainForm.pas' {FMXMainFrm};

{$R *.res}

var
  Model: TOrders;
  Controller: TAppController;

begin
{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Model := TOrders.Create;
  try
    Controller := TAppController.Create;
    try
      Controller.StartApp(TFMXFormViewHandler.Create, Model);
    finally
      Controller.Free;
    end;
  finally
    Model.Free;
  end;

end.
