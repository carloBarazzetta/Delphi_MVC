program VCLApp;

uses
  Vcl.Forms,
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
  VCLFormViewHandler in '..\Source\VCLFormViewHandler.pas',
  VCLMainForm in '..\Source\VCLMainForm.pas' {VCLMainFrm},
  VCLOrdersForm in '..\Source\VCLOrdersForm.pas' {VCLOrdersFrm},
  VCLCoutriesForm in '..\Source\VCLCoutriesForm.pas' {VCLCountriesFrm},
  VCLOrderForm in '..\Source\VCLOrderForm.pas' {VCLOrderFrm},
  VCLCustomersForm in '..\Source\VCLCustomersForm.pas' {VCLCustomersFrm};

{$R *.res}

var
  Model: TModel;
  Controller: TAppController;

begin
{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Model := TModel.Create;
  try
    CreateRandomData(Model, 10);
    Controller := TAppController.Create(Model);
    try
      Application.Title := Controller.AppTitle;
      Controller.StartApp(TVCLFormViewHandler.Create, Model);
    finally
      Controller.Free;
    end;
  finally
    Model.Free;
  end;

  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
end.
