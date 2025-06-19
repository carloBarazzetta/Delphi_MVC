{******************************************************************************}
{       Orders/Customers MVC: An Orders/Customers with MVC Pattern (VCL+FMX)   }
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
unit AppController;

interface

uses
  Model
  , System.Generics.Collections
  , Order, Orders
  , Customer, Customers
  , Country
  ;

type
  TAppController = class;

  IView = interface
    procedure SetModelAndController(const AModel: TModel;
      const AController: TAppController);
    procedure RefreshView;
  end;

  IContainerView = interface(IView)
    ['{2FA8C0F7-2BC5-49C4-8F82-43658514EBD2}']
    //Display Embedded View
    procedure DisplayEmbeddedView(const AView: IView);
  end;

  ICustomersView = interface(IView)
    ['{29B6A84D-164E-4233-BC51-7BE2573E09B5}']
    procedure DisplayCustomers;
    //procedure DisplayCustomer(const ACustomer: TCustomer);
  end;

  IOrdersView = interface(IView)
    ['{90EF5DC4-05E2-4950-A767-157ED506A9A6}']
    procedure DisplayOrders(const ACustomer: TCustomer = nil);
  end;

  IOrderView = interface(IView)
    ['{F5C14C01-E9C7-45D1-A25D-E9406DEBCFF0}']
    procedure DisplayOrder(const AOrder: TOrder;
      const ACustomer: TCustomer = nil);
  end;

  IApplyFilter = interface
    //Display Filtered View
    procedure RefreshView(const AMainObject: TObject);
  end;

  IViewHandler = interface
    function CreateMainView(const AModel: TModel;
      const AController: TAppController): IContainerView;
    function CreateCustomersView(const AModel: TModel;
      const AController: TAppController;
      const AContainer: IContainerView = nil): ICustomersView;
    function CreateOrdersView(const AModel: TModel;
      const AController: TAppController;
      const AContainer: IContainerView = nil): IOrdersView;
    function CreateOrderView(const AModel: TModel;
      const AController: TAppController;
      const AOrder: TOrder; const ACustomer: TCustomer = nil): IOrderView;
    procedure ApplyFilter(const AView: IView; const AFilter: IApplyFilter);
    function YesNo(const AQuestion: string): Boolean;
    procedure RefreshCurrentView;
  end;

  TAppController = class
  strict private
    FModel: TModel;
    FViewHandler: IViewHandler;
    FMainView: IContainerView;
  private
  public
    constructor Create(const AModel: TModel);
    function AppTitle: string;
    procedure StartApp(viewHandler: IViewHandler; Model: TModel);
    procedure AddOrder(Order: TOrder);
    procedure SaveOrder(const Order: TOrder);
    procedure DeleteOrder(const AId: Integer);
    function RetrieveOrder(const AId: Integer;
      const ARaiseError: Boolean = False): TOrder;
    procedure AddCustomer(Customer: TCustomer);
    procedure DeleteCustomer(const AId: Integer);
    function RetrieveCustomer(const AId: Integer;
      const ARaiseError: Boolean = False): TCustomer;
    function CreateCustomersView(const AContainer: IContainerView = nil): ICustomersView;
    function CreateOrdersView(const AContainer: IContainerView = nil;
      const ACustomer: TCustomer = nil): IOrdersView;
    function CreateOrderView(const AOrder: TOrder;
      const ACustomer: TCustomer = nil): IOrderView;
  end;

implementation

uses
  System.SysUtils
  ;

{ TAppController }

function TAppController.CreateCustomersView(
  const AContainer: IContainerView = nil): ICustomersView;
begin
  Result := FViewHandler.CreateCustomersView(FModel, Self, AContainer);
  Result.DisplayCustomers;
end;

function TAppController.CreateOrdersView(
  const AContainer: IContainerView = nil;
  const ACustomer: TCustomer = nil): IOrdersView;
begin
  Result := FViewHandler.CreateOrdersView(FModel, Self, AContainer);
  Result.DisplayOrders(ACustomer);
end;

function TAppController.CreateOrderView(const AOrder: TOrder;
  const ACustomer: TCustomer): IOrderView;
begin
  FViewHandler.CreateOrderView(FModel, Self, AOrder, ACustomer);
end;

procedure TAppController.SaveOrder(const Order: TOrder);
begin
  var LOrder := RetrieveOrder(Order.Id);
  if Assigned(LOrder) then
    LOrder.Assign(Order);
  FViewHandler.RefreshCurrentView;
end;

procedure TAppController.StartApp(viewHandler: IViewHandler; Model: TModel);
begin
  Self.FModel := Model;
  Self.FViewHandler := viewHandler;
  FMainView := viewHandler.CreateMainView(Model, Self);
  FViewHandler.RefreshCurrentView;
end;

function TAppController.AppTitle: string;
begin
  Result := 'M.V.C. - CUSTOMER - ORDERS MANAGER';
end;

constructor TAppController.Create(const AModel: TModel);
begin
  FModel := AModel;
end;

procedure TAppController.AddOrder(Order: TOrder);
begin
  if FViewHandler.YesNo(
    Format('Confirm Adding Order "%s"?',[Order.Text])) then
    FModel.Orders.AddOrder(Order);
  FViewHandler.RefreshCurrentView;
end;

procedure TAppController.DeleteOrder(const AId: Integer);
begin
  var LOrder := RetrieveOrder(AId, True);
  if FViewHandler.YesNo(Format('Really delete "%s"?',[LOrder.Text])) then
  begin
    FModel.Orders.DeleteOrder(LOrder);
  end;
  FViewHandler.RefreshCurrentView;
end;

function TAppController.RetrieveOrder(const AId: Integer;
  const ARaiseError: Boolean = False): TOrder;
begin
  Result := FModel.Orders.FindOrder(AId);
  if not Assigned(Result) and ARaiseError then
    raise Exception.Create(Format('Error: Order Id: %d not Found!',[AId]));
end;

procedure TAppController.AddCustomer(Customer: TCustomer);
begin
  if FViewHandler.YesNo(
    Format('Confirm Adding Customer "%s"?',[Customer.Name])) then
    FModel.Customers.AddCustomer(Customer);
  FViewHandler.RefreshCurrentView;
end;

procedure TAppController.DeleteCustomer(const AId: Integer);
begin
  var LCustomer := RetrieveCustomer(AId, True);
  if FViewHandler.YesNo(Format('Really delete "%s"?',[LCustomer.Name])) then
  begin
    FModel.Customers.DeleteCustomer(LCustomer);
  end;
  FViewHandler.RefreshCurrentView;
end;

function TAppController.RetrieveCustomer(const AId: Integer;
  const ARaiseError: Boolean = False): TCustomer;
begin
  Result := FModel.Customers.FindCustomer(AId);
  if not Assigned(Result) and ARaiseError then
    raise Exception.Create(Format('Error: Customer Id: %d not Found!',[AId]));
end;

end.
