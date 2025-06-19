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
unit Order;

interface

uses
  Customer
  ;

type
  TOrder = class
  private
    FId: Integer;
    FDiscountedPrice: Currency;
    FText: string;
    FFullPrice: Currency;
    FCustomer: TCustomer;
    procedure SetDiscountedPrice(const Value: Currency);
    procedure SetFullPrice(const Value: Currency);
    procedure SetText(const Value: string);
    procedure SetCustomer(const Value: TCustomer);
  public
    procedure Assign(ASource: TOrder);
    constructor Create;
    property Id: Integer read FId;
    property Text: string read FText write SetText;
    property FullPrice: Currency read FFullPrice write SetFullPrice;
    property DiscountedPrice: Currency read FDiscountedPrice write SetDiscountedPrice;
    property Customer: TCustomer read FCustomer write SetCustomer;
  end;

implementation

{ TOrder }

procedure TOrder.Assign(ASource: TOrder);
begin
  FId := ASource.Id;
  Text := ASource.Text;
  FullPrice := ASource.FullPrice;
  DiscountedPrice := ASource.DiscountedPrice;
  Customer := ASource.Customer;
end;

constructor TOrder.Create;
begin
  //Random Id
  FId := Random(100000);
end;

procedure TOrder.SetCustomer(const Value: TCustomer);
begin
  FCustomer := Value;
end;

procedure TOrder.SetDiscountedPrice(const Value: Currency);
begin
  FDiscountedPrice := Value;
end;

procedure TOrder.SetFullPrice(const Value: Currency);
begin
  FFullPrice := Value;
end;

procedure TOrder.SetText(const Value: string);
begin
  FText := Value;
end;

end.
