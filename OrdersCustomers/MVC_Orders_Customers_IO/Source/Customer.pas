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
unit Customer;

interface

uses
  Country
  , System.Classes
  , InstantPersistence
  ;

type
  TCustomer = class(TInstantObject)
  strict private
  private
    FId: Integer;
    FPhoneNumber: string;
    FCompanyName: string;
    FCity: string;
    FAddress: string;
    FFirstName: string;
    FLastName: string;
    FZip: string;
    FCountry: TCountry;
    FEmail: string;
    procedure SetAddress(const Value: string);
    procedure SetCity(const Value: string);
    procedure SetCompanyName(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetPhoneNumber(const Value: string);
    procedure SetZip(const Value: string);
    procedure SetCountry(const Value: TCountry);
    function GetName: string;
    procedure SetEmail(const Value: string);
  public
    constructor Create(AModel: TObject); reintroduce;
  published
    property Id: Integer read FId;
    property FirstName: string read FFirstName write SetFirstName;
    property LastName: string read FLastName write SetLastName;
    property CompanyName: string read FCompanyName write SetCompanyName;
    property Address: string read FAddress write SetAddress;
    property City: string read FCity write SetCity;
    property Zip: string read FZip write SetZip;
    property Country: TCountry read FCountry write SetCountry;
    property PhoneNumber: string read FPhoneNumber write SetPhoneNumber;
    property Email: string read FEmail write SetEmail;
    property Name: string read GetName;
  end;

implementation

uses
  System.SysUtils
  , Countries
  , Model
  ;

{ TCustomer }

constructor TCustomer.Create(AModel: TObject);
begin
  inherited Create;
  //Random Id
  FId := Random(100000);
  //Default Country 'IT'
  FCountry := (AModel as TModel).Countries.FindCountry('IT');
end;

function TCustomer.GetName: string;
begin
  if FCompanyName <> '' then
    Result := FCompanyName
  else
    Result := Format('%s %s', [FLastName, FFirstName]);
end;

procedure TCustomer.SetAddress(const Value: string);
begin
  FAddress := Value;
end;

procedure TCustomer.SetCity(const Value: string);
begin
  FCity := Value;
end;

procedure TCustomer.SetCompanyName(const Value: string);
begin
  FCompanyName := Value;
  if FCompanyName <> '' then
  begin
    FLastName := '';
    FFirstName := '';
  end;
end;

procedure TCustomer.SetCountry(const Value: TCountry);
begin
  FCountry := Value;
end;

procedure TCustomer.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TCustomer.SetFirstName(const Value: string);
begin
  FFirstName := Value;
  if FFirstName <> '' then
    FCompanyName := '';
end;

procedure TCustomer.SetLastName(const Value: string);
begin
  FLastName := Value;
  if FLastName <> '' then
    FCompanyName := '';
end;

procedure TCustomer.SetPhoneNumber(const Value: string);
begin
  FPhoneNumber := Value;
end;

procedure TCustomer.SetZip(const Value: string);
begin
  FZip := Value;
end;

initialization
  RegisterClass(TCustomer);

end.
