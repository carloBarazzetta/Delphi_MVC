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
unit DemoData;

interface

uses
  System.Classes
  , RandomData
  , Model
  , Order
  , Customer
  ;

const
  CategoryNames: array[0..5] of string = (
    'Undefined',
    'Customer',
    'Supplier',
    'Family',
    'Friend',
    'Colleague'
  );

procedure CreateRandomData(const AModel: TModel; const ACustomerCount: Integer);
procedure CreateRandomCustomers(const AModel: TModel; const ACount: Integer);

implementation

uses
  Winapi.Windows
  , System.SysUtils
  ;

function CreateRandomCustomer(const AModel: TModel): TCustomer;
begin
  Result := TCustomer.Create(AModel);
  try
    if Random() > 0.5 then
    begin
      Result.CompanyName := RandomCompanyName;
    end
    else
    begin
      Result.FirstName := RandomName;
      Result.LastName := RandomLastName;
    end;
    Result.Address := RandomAddress;
    Result.PhoneNumber := RandomNumber(10);
    Result.City := RandomCity;
    Result.Zip := RandomNumber(5);
  except
    Result.Free;
    raise;
  end;
end;

function CreateRandomOrder(const ACustomer: TCustomer): TOrder;
begin
  Result := TOrder.Create;
  try
    Result.Text := RandomOrder;
    Result.FullPrice := RandomCurrency(999999);
    Result.DiscountedPrice := Result.FullPrice - (Result.FullPrice / 100 * Random(20));
    Result.Customer := ACustomer;
  except
    Result.Free;
    raise;
  end;
end;

procedure CreateRandomCustomers(const AModel: TModel; const ACount: Integer);
begin
  for var I := 0 to ACount -1 do
  begin
    var LCustomer := CreateRandomCustomer(AModel);
    AModel.Customers.AddCustomer(LCustomer);
    var LOrdersCount: Integer := Random(3)+1;
    for var J := 0 to LOrdersCount - 1 do
    begin
      var LOrder := CreateRandomOrder(LCustomer);
      AModel.Orders.AddOrder(LOrder);
    end;
  end;
end;


procedure CreateRandomData(const AModel: TModel; const ACustomerCount: Integer);
begin
  CreateRandomCustomers(AModel, ACustomerCount);
end;


(*
function CreateRandomPerson(Company: TCustomer; out Gender : TGender): TPerson;
var
  CompanyName: string;
  LCategoryId: string;
begin
  Result := TPerson.Create;
  try
    Gender := TGender(Random(2));
    Result.Name := RandomFullName(Gender);
    Result.BirthDate := Date - (20 * 365 + Random(365 * 50)); // 20 - 70 years old
    Result.BirthTime := Random;
    Result.Address := CreateRandomAddress;
    Result.Salary := 500 + Random(5000);

    LCategoryId := Format('CAT%.3d', [Random(5)+1]);
    Result.Category := TCategory.Retrieve(LCategoryId);
    Result.Category.Free; //dereference Retrieve
    CreateRandomPhones(Result, ['Home', 'Mobile']);
    if Assigned(Company) then
    begin
      Result.EmployBy(Company);
      CompanyName := InstantPartStr(Company.Name, 1, ' ');
    end else
      CompanyName := LowerCase(RandomName);
    CreateRandomEmails(Result, [CompanyName, 'gmail']);
  except
    Result.Free;
    raise;
  end;
end;
*)

end.
