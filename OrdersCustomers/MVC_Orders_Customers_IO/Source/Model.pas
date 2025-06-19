{******************************************************************************}
{       Orders/Customers IO: An Orders/Customers with MVC and InstantObjects   }
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
unit Model;

interface

uses
  System.SysUtils
  , System.Generics.Collections
  , Orders
  , Customers
  , Countries
  ;

type
  TModel = class
    FCountries: TCountries;
    FOrders: TOrders;
    FCustomers: TCustomers;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Countries: TCountries read FCountries;
    property Orders: TOrders read FOrders;
    property Customers: TCustomers read FCustomers;
  end;

implementation

{ TModel }

constructor TModel.Create;
begin
  inherited Create;
  FCountries := TCountries.Create;
  FCustomers := TCustomers.Create;
  FOrders := TOrders.Create;
end;

destructor TModel.Destroy;
begin
  FreeAndNil(FCountries);
  FreeAndNil(FCustomers);
  FreeAndNil(FOrders);
  inherited;
end;

end.
