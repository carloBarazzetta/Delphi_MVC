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
unit DataModel;

interface

uses
  Model
  , InstantPersistence
  , InstantBrokers
  , InstantXML
  ;

type
  TDataModel = class(TModel)
  private
    FAccessor: TXMLFilesAccessor;
    FConnector: TInstantXMLConnector;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TDataModel }

uses
  System.SysUtils
  ;

constructor TDataModel.Create;
begin
  inherited Create;
  FAccessor := TXMLFilesAccessor.Create(nil);
  FAccessor.RootFolder := ExtractFilePath(GetModuleName(hinstance))+'..\..\Data';
  FConnector := TInstantXMLConnector.Create(nil);
  FConnector.Connection := FAccessor;
  FConnector.IsDefault := True;
end;

destructor TDataModel.Destroy;
begin
  FreeAndNil(FConnector);
  FreeAndNil(FAccessor);
  inherited;
end;

end.
