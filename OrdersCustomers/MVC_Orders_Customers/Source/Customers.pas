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
unit Customers;

interface

uses
  System.Generics.Collections
  , Customer
  ;

type
  TCustomers = class
  private
    FList: TObjectList<TCustomer>;
  public
    function FindCustomer(const AId: Integer): TCustomer;
    constructor Create;
    destructor Destroy; override;
    function GetAllCustomers: TObjectList<TCustomer>;
    procedure AddCustomer(ACustomer: TCustomer);
    procedure DeleteCustomer(const ACustomer: TCustomer);
  end;

implementation

uses
  System.SysUtils
  ;

{ TCustomers }

constructor TCustomers.Create;
begin
  inherited;
  FList := TObjectList<TCustomer>.Create(True);
end;

destructor TCustomers.Destroy;
begin
  FList.Clear;
  FreeAndNil(FList);
  inherited;
end;

function TCustomers.FindCustomer(const AId: Integer): TCustomer;
begin
  Result := nil;
  for var CurrentCustomer in FList do
  begin
    if CurrentCustomer.Id = AId then
    begin
      Result := CurrentCustomer;
      Break;
    end;
  end;
end;

function TCustomers.GetAllCustomers: TObjectList<TCustomer>;
begin
  Result := FList;
end;

procedure TCustomers.AddCustomer(ACustomer: TCustomer);
begin
  FList.Add(ACustomer);
end;

procedure TCustomers.DeleteCustomer(const ACustomer: TCustomer);
begin
  FList.Remove(ACustomer);
end;

end.

