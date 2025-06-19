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
unit Orders;

interface

uses
  System.Generics.Collections
  , Order
  , Customer;

type
  TOrders = class
  private
    FList: TObjectList<TOrder>;
    FListForCustomer: TObjectList<TOrder>;
  public
    function FindOrder(const AId: Integer): TOrder;
    constructor Create;
    destructor Destroy; override;
    function GetAllOrders: TObjectList<TOrder>; overload;
    function GetAllOrders(const ACustomer: TCustomer): TObjectList<TOrder>; overload;
    procedure AddOrder(AOrder: TOrder);
    procedure DeleteOrder(const AOrder: TOrder);
  end;

implementation

uses System.SysUtils;

{ TOrders }

constructor TOrders.Create;
begin
  inherited;
  FList := TObjectList<TOrder>.Create(True); //Owns Objects
  FListForCustomer := TObjectList<TOrder>.Create(False);
end;

destructor TOrders.Destroy;
begin
  FList.Clear;
  FreeAndNil(FList);
  FreeAndNil(FListForCustomer);
  inherited;
end;

function TOrders.FindOrder(const AId: Integer): TOrder;
begin
  Result := nil;
  for var CurrentOrder in FList do
  begin
    if CurrentOrder.Id = AId then
    begin
      Result := CurrentOrder;
      Break;
    end;
  end;
end;

function TOrders.GetAllOrders(const ACustomer: TCustomer): TObjectList<TOrder>;
begin
  if Assigned(ACustomer) then
  begin
    FListForCustomer.Clear;
    for var LOrder in FList do
    begin
      if LOrder.Customer = ACustomer then
        FListForCustomer.Add(LOrder);
    end;
    Result := FListForCustomer;
  end
  else
    Result := GetAllOrders;
end;

function TOrders.GetAllOrders: TObjectList<TOrder>;
begin
  Result := FList;
end;

procedure TOrders.AddOrder(AOrder: TOrder);
begin
  FList.Add(AOrder);
end;

procedure TOrders.DeleteOrder(const AOrder: TOrder);
begin
  FList.Remove(AOrder);
end;

end.
