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
unit RandomData;

interface

type
  TGender = (gnMale, gnFemale);

function RandomName: string;
function RandomCompanyName: string;
function RandomEmail(const PersonName, DomainName: string): string;
function RandomFirstName(Gender: TGender): string;
function RandomFullName(Gender: TGender): string;
function RandomLastName: string;
function RandomNumber(const Len: Integer): string;
function RandomAddress: string;
function RandomCity: string;
function RandomOrder: string;
function RandomCurrency(const Len: Integer): Currency;

implementation

uses
  System.SysUtils
  ;

const
  Letters = ['a'..'z'];
  Vowels = ['a', 'e', 'i', 'o', 'u', 'y'];
  Consonants = Letters - Vowels;

  SmartPrefixes: array[0..19] of string = (
    'cor', 'pri', 'pre', 'neo', 'new', 'or', 'hi', 'inter',
    'u', 'i', 'core', 'xo', 'xe', 'xor', 'xer', 'qua', 'gen',
    'in', 're', 'tri');

  SmartSuffixes: array[0..12] of string = (
    'teq', 'tex', 'tec', 'nix', 'lix', 'tor', 'max', 'time', 'qua',
    'paq', 'pac', 'nic', 'nec');

  FirstNames: array[TGender, 0..24] of string = ((
    'Anthony', 'Brian', 'Charles', 'Christopher', 'Daniel', 'David', 'Donald',
    'Edward', 'George', 'James', 'Jason', 'Jeff', 'John', 'Joseph', 'Kenneth',
    'Kevin', 'Mark', 'Michael', 'Paul', 'Richard', 'Robert', 'Ronald', 'Steven',
    'Thomas', 'William'), (
    'Barbara', 'Betty', 'Carol', 'Deborah', 'Donna', 'Dorothy', 'Elizabeth',
    'Helen', 'Jennifer', 'Karen', 'Kimberly', 'Laura', 'Linda', 'Lisa',
    'Margaret', 'Maria', 'Mary', 'Michelle', 'Nancy', 'Patricia', 'Ruth',
    'Sandra', 'Sarah', 'Sharon', 'Susan'));

  LastNames: array[0..49] of string = (
    'Adams', 'Allen', 'Anderson', 'Baker', 'Brown', 'Campbell', 'Carter',
    'Clark', 'Collins', 'Davis', 'Edwards', 'Evans', 'Garcia', 'Gonzalez',
    'Green', 'Hall', 'Harris', 'Hernandez', 'Hill', 'Jackson', 'Johnson',
    'Jones', 'King', 'Lee', 'Lewis', 'Lopez', 'Martin', 'Martinez', 'Miller',
    'Mitchell', 'Moore', 'Nelson', 'Parker', 'Perez', 'Phillips', 'Roberts',
    'Robinson', 'Rodriguez', 'Scott', 'Smith', 'Taylor', 'Thomas', 'Thompson',
    'Turner', 'Walker', 'White', 'Williams', 'Wilson', 'Wright', 'Young');

  Adjectives: array[0..19] of string = (
    'Intelligent', 'Smart', 'Wise', 'Bright', 'Essential', 'Basic', 'Happy',
    'Precise', 'Fast', 'Express', 'Simple', 'Good', 'Deluxe', 'Perfect',
    'Star', 'Future', 'Millenium', 'Solid', 'Sure', 'Great');

  CompanySuffixes: array[0..19] of string = (
    'Computers', 'Computing', 'Software', 'Technologies', 'Consulting', 'Food',
    'Furniture', 'Textiles', 'Wear', 'Toys', 'Adventures', 'Services', 'Tools',
    'Accessories', 'Entertainment', 'Flowers', 'Equipment', 'Items',
    'Architecture', 'Knowledge');

  CompanyTypes: array[0..2] of string = (
    'Corp.', 'Inc.', 'Ltd.');

  StreetPrefixes: array[0..3] of string = (
    'North', 'East', 'South', 'West');

  StreetBeginnings: array[0..16] of string = (
    'Salt', 'Sun', 'Moon', 'Stone', 'Rock', 'Clear', 'White', 'Green',
    'Corn', 'Shore', 'Cotton', 'Oak', 'Water', 'Bright', 'New', 'Old',
    'Apple');

  StreetEndings: array[0..6] of string = (
    'wood', 'dale', 'land', 'bridge', 'lake', 'hill', 'field');

  StreetTypes: array[0..7] of string = (
    'Street', 'Road', 'Avenue', 'Place', 'Court', 'Boulevard', 'Drive',
    'Parkway');

  Cities: array[0..29] of string = (
    'Alabama', 'Atlanta', 'Boston', 'Chicago', 'Cincinnati', 'Dallas', 'Denver',
    'Detroit', 'Houston', 'Indianapolis', 'Kansas City', 'Las Vegas',
    'Los Angeles', 'Memphis', 'Miami', 'Minneapolis', 'Nashville',
    'New Orleans', 'New York', 'Oklahoma', 'Omaha', 'Philadelphia',
    'Pittsburgh', 'Portland', 'San Diego', 'San Francisco', 'Seattle', 'Tampa',
    'Utah', 'Washington');

  Orders: array[0..29] of string = (
    '3 pairs of shoes','1 t-shirt','5 baseball caps','2 leather jackets','4 backpacks',
    '10 pairs of socks','1 smartwatch','6 sunglasses','8 bottles of water','2 umbrellas',
    '3 wireless chargers','1 laptop','7 notebooks','12 pens','2 bluetooth speakers','9 phone cases',
    '1 gaming console','4 HDMI cables','3 power banks','6 USB flash drives','1 office chair',
    '2 desk lamps','10 coffee mugs','5 throw pillows','3 yoga mats','2 fitness trackers',
    '4 bicycle helmets','7 packs of batteries','1 electric toothbrush','6 alarm clocks');

  DomainSuffixes: array[0..4] of string = (
    'com', 'org', 'net', 'edu', 'gov');

function RandomStr(List: array of string): string;
begin
  Result := List[Random(Length(List))];
end;

function RandomLetter: Char;
begin
  Result := Chr(Ord('a') + Random(Ord('z') - Ord('a')));
end;

function RandomConsonant: Char;
begin
  repeat
    Result := RandomLetter;
  until CharInSet(Result, Consonants);
end;

function RandomVowel: Char;
begin
  repeat
    Result := RandomLetter;
  until CharInSet(Result, Vowels);
end;

function RandomName: string;

  function SmartName: string;
  begin
    Result := RandomStr(SmartPrefixes) + RandomStr(SmartSuffixes);
  end;

  function CombiName: string;
  begin
    Result := RandomConsonant + RandomVowel;
    if Odd(Random(2)) then
      Result := Result + RandomConsonant;
    Result := Result + RandomStr(SmartSuffixes);
  end;

  function TripletName: string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 1 to 3 do
    begin
      Result := Result + RandomConsonant + RandomVowel;
      if Random(10) = 1 then
        Result := Result + RandomConsonant;
    end;
  end;

begin
  case Random(3) of
    0: Result := SmartName;
    1: Result := CombiName;
    2: Result := TripletName;
  end;
  Result[1] := UpCase(Result[1]);
end;

function RandomCompanyName: string;
begin
  if Random(3) = 0 then
    Result := RandomStr(Adjectives)
  else
    Result := RandomName;
  Result := Result + ' ' + RandomStr(CompanySuffixes) + ' ' +
    RandomStr(CompanyTypes);
end;

function RandomEmail(const PersonName, DomainName: string): string;
var
  Name, FirstName, LastName, Suffix: string;
  I: Integer;
begin
  I := Pos(' ', PersonName);
  if I > 0 then
  begin
    FirstName := Copy(PersonName, 1, Pred(I));
    LastName := PersonName;
    Delete(LastName, 1, I);
  end else
  begin
    FirstName := PersonName;
    LastName := '';
  end;
  case Random(3) of
    0: Name := FirstName + '.' + LastName;
    1: Name := Copy(FirstName, 1, 1) + Copy(LastName, 1, 1);
    2: Name := Copy(FirstName, 1, 1) + '_' + LastName;
  end;
  if Random(10) <> 0 then // 9 of 10 have .com
    Suffix := DomainSuffixes[0] else
    Suffix := RandomStr(DomainSuffixes);
  Result := LowerCase(Name + '@' + DomainName + '.' + Suffix);
end;

function RandomFirstName(Gender: TGender): string;
begin
  Result := FirstNames[Gender, Random(Length(FirstNames[gnMale]))];
end;

function RandomFullName(Gender: TGender): string;
begin
  Result := RandomFirstName(Gender) + ' ' + RandomLastName;
end;

function RandomLastName: string;
begin
  Result := RandomStr(LastNames);
end;

function RandomNumber(const Len: Integer): string;
begin
  Result := '';
  var LLen := Len;
  while LLen > 0 do
  begin
    Result := Result + Chr(Ord('0') + Random(10));
    Dec(LLen);
  end;
end;

function RandomCurrency(const Len: Integer): Currency;
begin
  Result := Random(Len);
end;

function RandomAddress: string;
begin
  if Random(8) = 0 then
    Result := RandomStr(StreetPrefixes) + ' ' else
    Result := '';
  Result := Result +
    RandomStr(StreetBeginnings) +
    RandomStr(StreetEndings) + ' ' +
    RandomStr(StreetTypes) + ' ' +
    IntToStr((Random(499) + 1) div (Random(9) + 1) + 1);
end;

function RandomCity: string;
begin
  Result := RandomStr(Cities);
end;

function RandomOrder: string;
begin
  Result := RandomStr(Orders);
end;

initialization
  Randomize;

end.
