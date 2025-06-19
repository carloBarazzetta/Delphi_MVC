program ConsoleApp;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Orders in '..\Source\Orders.pas',
  Order in '..\Source\Order.pas',
  AppController in '..\Source\AppController.pas',
  ConsoleViewHandler in '..\Source\ConsoleViewHandler.pas',
  ConsoleMainView in '..\Source\ConsoleMainView.pas';

var
  Model: TOrders;
  Controller: TAppController;

begin
{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Model := TOrders.Create;
  try
    try
      Controller := TAppController.Create;
      try
        Controller.StartApp(TConsoleViewHandler.Create, Model);
      finally
        Controller.Free;
      end;
    finally
      Model.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
