{******************************************************************************}
{       Simple MVC: A Simple Order Manager with MVC Pattern (VCL+FMX+Console)  }
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
unit VCLMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  AppController, Orders, Vcl.ComCtrls, Vcl.NumberBox;

type
  TVCLMainFrm = class(TForm, IView)
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    OrdersListView: TListView;
    OrderTextEdit: TEdit;
    FullPriceEdit: TNumberBox;
    DiscountPriceEdit: TNumberBox;
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
  strict private
    FController: TAppController;
    FModel: TOrders;
    //IView Interface
    procedure SetController(const Value: TAppController);
    procedure SetModel(const Value: TOrders);
    procedure RefreshView;
  end;

implementation

{$R *.dfm}

uses Order, System.Generics.Collections;

{ TVCLMainFrm }

procedure TVCLMainFrm.ButtonAddClick(Sender: TObject);
begin
  var Order := TOrder.Create;
  try
    Order.Text := OrderTextEdit.Text;
    Order.FullPrice := FullPriceEdit.Value;
    Order.DiscountedPrice := DiscountPriceEdit.Value;
    FController.AddOrder(Order);
  except
    Order.Free;
    raise;
  end;
end;

procedure TVCLMainFrm.ButtonDeleteClick(Sender: TObject);
begin
  var LIndex := OrdersListView.ItemIndex;
  if LIndex >= 0 then
  begin
    var LOrderId := StrToInt(OrdersListView.Items[LIndex].Caption);
    FController.DeleteOrder(LOrderId);
  end;
end;

procedure TVCLMainFrm.SetController(const Value: TAppController);
begin
  FController := Value;
  Caption := FController.AppTitle + ' - VCL';
end;

procedure TVCLMainFrm.SetModel(const Value: TOrders);
begin
  FModel := Value;
end;

procedure TVCLMainFrm.RefreshView;
var
  LOrders: TList<TOrder>;
  LOrder: TOrder;
begin
  LOrders := FModel.GetAllOrders();
  OrdersListView.Items.BeginUpdate;
  try
    OrdersListView.Clear;

    for LOrder in LOrders do
      with OrdersListView.Items.Add do
      begin
        Caption := IntToStr(LOrder.Id);
        SubItems.Add(LOrder.Text);
        SubItems.Add(FloatToStr(LOrder.FullPrice));
        SubItems.Add(FloatToStr(LOrder.DiscountedPrice));
      end;
  finally
    OrdersListView.Items.EndUpdate;
  end;
end;

end.
