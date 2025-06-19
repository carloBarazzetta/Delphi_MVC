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
unit ConsoleMainView;

interface

uses AppController, Orders;

type
  TConsoleMainView = class(TInterfacedObject, IView)
    procedure DeleteOrder;
    procedure AddOrder;
  strict private
    FController: TAppController;
    FModel: TOrders;
    //IView Interface
    procedure SetController(const Value: TAppController);
    procedure SetModel(const Value: TOrders);
    procedure RefreshView;

    procedure WriteTitle(const ATitle: string);
    procedure WriteSeparator;
    function InputValue(const ACaption: string): string;
    procedure AcceptUserInput;
  end;

implementation

uses
  Order
  , System.SysUtils
  , System.Generics.Collections
  ;

{ TConsoleMainView }

procedure TConsoleMainView.AddOrder;
begin
  var Order := TOrder.Create;
  try
    WriteTitle('ADD NEW ORDER');
    Order.Text := InputValue('Text');
    Order.FullPrice := StrToFloat(InputValue('FullPrice'));
    Order.DiscountedPrice := StrToFloat(InputValue('Discounted Price'));
    FController.AddOrder(Order);
  except
    Order.Free;
    raise;
  end;
end;

procedure TConsoleMainView.DeleteOrder;
begin
  WriteLn('DELETE ORDER');
  var LOrderId := StrToInt(InputValue('Order Id'));
  FController.DeleteOrder(LOrderId);
end;

procedure TConsoleMainView.SetController(const Value: TAppController);
begin
  FController := Value;
  WriteTitle(FController.AppTitle + ' - CONSOLE');
end;

function TConsoleMainView.InputValue(const ACaption: string): string;
begin
  Write(Format('Input value for %s: ',[ACaption]));
  System.Readln(Result);
  WriteSeparator;
end;

procedure TConsoleMainView.SetModel(const Value: TOrders);
begin
  FModel := Value;
end;

procedure TConsoleMainView.WriteTitle(const ATitle: string);
begin
  WriteLn('');
  WriteLn(ATitle);
  WriteSeparator;
end;

procedure TConsoleMainView.WriteSeparator;
begin
  System.Writeln('=======================================');
end;

procedure TConsoleMainView.AcceptUserInput;
var
  S: string;
begin
  while True do
  begin
    try
      WriteTitle('USER INPUT');
      System.Write('[A]dd new Order, [D]elete an Order, [E]xit: ');
      System.Readln(S);
      if SameText(S, 'a') then
      begin
        AddOrder;
      end
      else if SameText(S, 'd') then
        DeleteOrder
      else if SameText(S, 'e') then
      begin
        WriteTitle('Quit application.');
        Halt(0);
      end;
    except
      On E: Exception do
      begin
        WriteTitle('ERROR:');
        System.WriteLn(E.message);
      end;
    end;
  end;
end;

procedure TConsoleMainView.RefreshView;
var
  LOrders: TObjectList<TOrder>;
  LOrder: TOrder;
begin
  LOrders := FModel.GetAllOrders();
  WriteTitle('ORDER LIST');
  for LOrder in LOrders do
  begin
    System.Writeln('Id: ', IntToStr(LOrder.Id));
    System.Writeln('Text: ',LOrder.Text);
    System.Writeln('FullPrice: ', FloatToStr(LOrder.FullPrice));
    System.Writeln('Discounted Price: ', FloatToStr(LOrder.DiscountedPrice));
    WriteSeparator;
  end;
  AcceptUserInput;
end;

end.
