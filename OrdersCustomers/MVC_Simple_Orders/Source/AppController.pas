{******************************************************************************}
{       Simple MVC: A Simple Order Manager with MVC Pattern (VCL+FMX+Console)  }
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

uses Orders, Order;

type
  TAppController = class;

  IView = interface(IInterface)
    ['{A59FE2EF-43C0-4760-AD7E-E2F0EB1FB37E}']
    procedure SetController(const Value: TAppController);
    procedure SetModel(const Value: TOrders);
    procedure RefreshView;
  end;

  IViewHandler = interface(IInterface)
    ['{19A05C30-E015-411C-A115-7A624A5E254D}']
    function CreateMainView(Model: TOrders; Controller: TAppController): IView;
    procedure ShowMainView(mainView: IView);
    function YesNo(const AQuestion: string): Boolean;
  end;

  TAppController = class
  strict private
    FModel: TOrders;
    FViewHandler: IViewHandler;
    FMainView: IView;
  public
    function AppTitle: string;
    procedure StartApp(viewHandler: IViewHandler; Model: TOrders);
    procedure AddOrder(Order: TOrder);
    procedure DeleteOrder(const AId: Integer);
    function RetrieveOrder(const AId: Integer;
      const ARaiseError: Boolean = False): TOrder;
  end;

implementation

uses
  System.SysUtils
  ;

{ TAppController }

procedure TAppController.StartApp(viewHandler: IViewHandler; Model: TOrders);
begin
  Self.FModel := Model;
  Self.FViewHandler := viewHandler;
  FMainView := viewHandler.CreateMainView(Model, Self);
  viewHandler.ShowMainView(FMainView);

end;

procedure TAppController.AddOrder(Order: TOrder);
begin
  if FViewHandler.YesNo(
    Format('Confirm Adding Order "%s"?',[Order.Text])) then
    FModel.AddOrder(Order);
  FMainView.RefreshView;
end;

function TAppController.AppTitle: string;
begin
  Result := 'M.V.C. - ORDERS MANAGER';
end;

procedure TAppController.DeleteOrder(const AId: Integer);
begin
  var LOrder := RetrieveOrder(AId, True);
  if FViewHandler.YesNo(Format('Really delete "%s"?',[LOrder.Text])) then
  begin
    FModel.DeleteOrder(LOrder);
  end;
  FMainView.RefreshView;
end;

function TAppController.RetrieveOrder(const AId: Integer;
  const ARaiseError: Boolean = False): TOrder;
begin
  Result := FModel.FindOrder(AId);
  if not Assigned(Result) and ARaiseError then
    raise Exception.Create(Format('Error: Order Id: %d not Found!',[AId]));
end;

end.
