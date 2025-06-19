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
unit Countries;

interface

uses
  System.Generics.Collections
  , Country;

type
  TCountries = class
  private
    FList: TObjectList<TCountry>;
  public
    function FindCountry(const AIsoCode: string): TCountry;
    constructor Create;
    destructor Destroy; override;
    function GetAllCountries: TObjectList<TCountry>;
    procedure AddCountry(ACountry: TCountry);
    procedure DeleteCountry(const ACountry: TCountry);
  end;

implementation

uses System.SysUtils;

{ TCountries }

constructor TCountries.Create;
const
  CountryNames: array[0..29] of string = (
    'AR:Argentina',
    'AT;Austria',
    'AU;Australia',
    'BE;Belgium',
    'BR;Brazil',
    'CA;Canada',
    'CH;Switzerland',
    'DE;Germany',
    'DK;Denmark',
    'EE;Estonia',
    'ES;Spain',
    'FR;France',
    'GR;Greece',
    'HK;Hong Kong',
    'IT;Italy',
    'MX;Mexico',
    'MY;Malaysia',
    'NL;Netherlands',
    'NO;Norway',
    'NZ;New Zealand',
    'PL;Poland',
    'PT;Portugal',
    'RU;Russia',
    'SE;Sweden',
    'SG;Singapore',
    'TW;Taiwan',
    'UA;Ukraine',
    'UK;United Kingdom',
    'US;United States',
    'ZA;South Africa'
  );

var
  I: Integer;
  S: string;
  LCountry: TCountry;
begin
  inherited;
  FList := TObjectList<TCountry>.Create(True);

  for I := Low(CountryNames) to High(CountryNames) do
  begin
    LCountry := TCountry.Create;
    S := CountryNames[I];
    LCountry.IsoCode := Copy(S, 1, 2);
    LCountry.Name := Copy(S, 4, Length(S));
    AddCountry(LCountry);
  end;
end;

destructor TCountries.Destroy;
begin
  FList.Clear;
  FreeAndNil(FList);
  inherited;
end;

function TCountries.FindCountry(const AIsoCode: string): TCountry;
begin
  Result := nil;
  for var CurrentCountry in FList do
  begin
    if CurrentCountry.IsoCode = AIsoCode then
    begin
      Result := CurrentCountry;
      Break;
    end;
  end;
end;

function TCountries.GetAllCountries: TObjectList<TCountry>;
begin
  Result := FList;
end;

procedure TCountries.AddCountry(ACountry: TCountry);
begin
  FList.Add(ACountry);
end;

procedure TCountries.DeleteCountry(const ACountry: TCountry);
begin
  FList.Remove(ACountry);
end;

end.
