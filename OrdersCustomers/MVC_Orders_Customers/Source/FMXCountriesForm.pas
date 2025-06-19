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
unit FMXCountriesForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, 
  FMX.Layouts, FMX.TreeView, FMX.Grid, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox
  , System.Generics.Collections
  , AppController
  , Model
  , Countries, Country;

type
  TFMXCountriesFrm = class(TForm, IInterface, ICountriesView)
    CountriesListView: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
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

{$R *.fmx}

{ TFMXCountriesFrm }

procedure TFMXCountriesFrm.DisplayCountries;
begin
  Show;
  RefreshView;
end;

procedure TFMXCountriesFrm.SetModelAndController(const AModel: TModel;
  const AController: TAppController);
begin
  FModel := AModel;
  FController := AController;
end;

procedure TFMXCountriesFrm.RefreshCountriesList;
begin
  var LCountries := FModel.Countries.GetAllCountries;
  CountriesListView.RowCount := LCountries.Count;
  var I := 0;
  for var LCountry in LCountries do
  begin
    CountriesListView.Cells[0, I] := LCountry.IsoCode;
    CountriesListView.Cells[1, I] := LCountry.Name;
    Inc(I);
  end;
end;

procedure TFMXCountriesFrm.RefreshView;
begin
  RefreshCountriesList;
end;

end.
