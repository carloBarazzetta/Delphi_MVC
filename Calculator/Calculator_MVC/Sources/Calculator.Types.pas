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
unit Calculator.Types;

interface

uses
  System.SysUtils
  ;

Type
  ECalculatorException = class(Exception);

 //Define Operator Type
 TOperatorType = (
    opNone,
    opAdd,
    opSubtract,
    opMultiply,
    opDivide,
    opSqrt,
    opSquare,
    opReciprocal,
    opPercent,
    opNegate,
    opEqual
  );

  //Define user operations
  TCalcOperation = (
    coNone,
    coAdd,
    coSubtract,
    coMultiply,
    coDivide,
    coSqrt,
    coSquare,
    coReciprocal,
    coPercent,
    coNegate,
    coEqual,
    coBack,
    coClearAll,
    coClearEntry
  );

const
  None_Caption = '';
  Add_Caption = '+';
  Subtract_Caption = #$2212;
  Multiply_Caption = #$00D7;
  Divide_Caption = #$00F7;
  Sqrt_Caption = #8730+'x';
  Square_Caption = 'x'+#178;
  Reciprocal_Caption = #$00B9+#$2215+'x';
  Percent_Caption = '%';
  Negate_Caption = #$00B1;
  Equal_Caption = '=';
  Back_Caption = #$232B;
  ClearAll_Caption = 'C';
  ClearEntry_Caption = 'CE';

  TCalcOperationCaption: array[TCalcOperation] of string = (
    None_Caption,
    Add_Caption,
    Subtract_Caption,
    Multiply_Caption,
    Divide_Caption,
    Sqrt_Caption,
    Square_Caption,
    Reciprocal_Caption,
    Percent_Caption,
    Negate_Caption,
    Equal_Caption,
    Back_Caption,
    ClearAll_Caption,
    ClearEntry_Caption
    );

  TCalculatorDigits : Set of Char =
    ['0','1','2','3','4','5','6','7','8','9'];

implementation

end.
