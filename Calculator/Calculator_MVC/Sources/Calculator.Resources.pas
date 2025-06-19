{******************************************************************************}
{       Calculator MVC: An example of Calculator with MVC Pattern (VCL+FMX)    }
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
unit Calculator.Resources;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection, Vcl.ImageCollection;

resourcestring
  UNEXPECTED_ERROR = 'Unexpected Error!';
  DIVISION_BY_ZERO = 'Division by zero';
  INVALID_SQUARE_ROOT = 'Invalid square root';

type
  TdmResources = class(TDataModule)
    ImageCollection: TImageCollection;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIniFileName: TFileName;
  public
    //Variabili che contengono i valori letti dal file .ini
    Application_Theme: string;
    MainFormPos_Left, MainFormPos_Top, MainFormPos_Width, MainFormPos_Height: Integer;
    procedure LoadInifile(const AIniFileName: TFileName);
    procedure SaveInifile;
  end;

var
  dmResources: TdmResources;

implementation

uses
  System.Inifiles;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmResources }

procedure TdmResources.DataModuleCreate(Sender: TObject);
begin
  //Read application configuration
  LoadInifile(ChangeFileExt(GetModuleName(HInstance),'.ini'));
end;

procedure TdmResources.LoadInifile(const AIniFileName: TFileName);
begin
  FIniFileName := AIniFileName;
  var LIniFile := TIniFile.Create(FIniFileName);
  try
    Application_Theme := LIniFile.ReadString('Application', 'Theme', 'Windows10');
    MainFormPos_Left := LIniFile.ReadInteger('MainFormPosition', 'Left', 100);
    MainFormPos_Top  := LIniFile.ReadInteger('MainFormPosition', 'Top', 100);
    MainFormPos_Width := LIniFile.ReadInteger('MainFormPosition', 'Width', 330);
    MainFormPos_Height := LIniFile.ReadInteger('MainFormPosition', 'Height', 450);
  finally
    LIniFile.Free;
  end;
end;

procedure TdmResources.SaveInifile;
begin
  var LIniFile := TIniFile.Create(FIniFileName);
  try
    LIniFile.WriteString('Application', 'Theme', Application_Theme);
    LIniFile.WriteInteger('MainFormPosition', 'Left', MainFormPos_Left);
    LIniFile.WriteInteger('MainFormPosition', 'Top', MainFormPos_Top);
    LIniFile.WriteInteger('MainFormPosition', 'Width', MainFormPos_Width);
    LIniFile.WriteInteger('MainFormPosition', 'Height', MainFormPos_Height);
  finally
    LIniFile.Free;
  end;
end;

end.
