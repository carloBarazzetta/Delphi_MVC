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
unit VCLCountriesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.NumberBox
  , System.Generics.Collections
  , AppController
  , Model
  , Countries, Country;

type
  TVCLCountriesFrm = class(TForm, IInterface, ICountriesView)
    CountriesListView: TListView;
  strict private
    FController: TAppController;
    FModel: TModel;
    //IView Interface
    procedure SetModelAndController(const AModel: TModel;
      const AController: TAppController);
    procedure RefreshView;
    //ICountriesView Interface
    procedure DisplayCountries;
  private
    procedure RefreshCountriesList;
  public
  end;

implementation

{$R *.dfm}

{ TVCLCountriesFrm }

procedure TVCLCountriesFrm.DisplayCountries;
begin
  Show;
  RefreshView;
end;

procedure TVCLCountriesFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TVCLCountriesFrm.RefreshCountriesList;

begin
  var LCountries := FModel.Countries.GetAllCountries;
  CountriesListView.Items.BeginUpdate;
  try
    CountriesListView.Clear;

    for var LCountry in LCountries do
      with CountriesListView.Items.Add do
      begin
        Caption := LCountry.IsoCode;
        SubItems.Add(LCountry.Name);
      end;
  finally
    CountriesListView.Items.EndUpdate;
  end;
end;

procedure TVCLCountriesFrm.RefreshView;
begin
  RefreshCountriesList;
end;

end.
