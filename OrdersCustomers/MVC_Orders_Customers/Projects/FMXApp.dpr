program VCLApp;

uses
  FMX.Forms,
  Model in '..\Source\Model.pas',
  Orders in '..\Source\Orders.pas',
  Order in '..\Source\Order.pas',
  Customers in '..\Source\Customers.pas',
  Customer in '..\Source\Customer.pas',
  Countries in '..\Source\Countries.pas',
  Country in '..\Source\Country.pas',
  DemoData in '..\Source\DemoData.pas',
  RandomData in '..\Source\RandomData.pas',
  AppController in '..\Source\AppController.pas',
  FMXFormViewHandler in '..\Source\FMXFormViewHandler.pas',
  FMXMainForm in '..\Source\FMXMainForm.pas' {FMXMainFrm},
  FMXOrdersForm in '..\Source\FMXOrdersForm.pas' {FMXOrdersFrm},
  FMXOrderForm in '..\Source\FMXOrderForm.pas' {FMXOrderFrm},
  FMXCustomersForm in '..\Source\FMXCustomersForm.pas' {FMXCustomersFrm};

{$R *.res}

var
  Model: TModel;
  Controller: TAppController;

begin
{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Model := TModel.Create;
  try
    CreateRandomData(Model, 10);
    Controller := TAppController.Create(Model);
    try
      Application.Title := Controller.AppTitle;
      Controller.StartApp(TFMXFormViewHandler.Create, Model);
    finally
      Controller.Free;
    end;
  finally
    Model.Free;
  end;

end.
