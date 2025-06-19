program VCLApp;

uses
  Vcl.Forms,
  Orders in '..\Source\Orders.pas',
  Order in '..\Source\Order.pas',
  AppController in '..\Source\AppController.pas',
  VCLFormViewHandler in '..\Source\VCLFormViewHandler.pas',
  VCLMainForm in '..\Source\VCLMainForm.pas' {VCLMainFrm};

{$R *.res}

var
  Model: TOrders;
  Controller: TAppController;

begin
{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Model := TOrders.Create;
  try
    Controller := TAppController.Create;
    try
      Application.Title := Controller.AppTitle;
      Controller.StartApp(TVCLFormViewHandler.Create, Model);
    finally
      Controller.Free;
    end;
  finally
    Model.Free;
  end;

end.
