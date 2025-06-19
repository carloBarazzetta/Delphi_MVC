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

  //Define user input
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
(*
  TCalcState = record
    CurrentValue: Double;          // The number currently shown
    StoredValue: Double;           // Stored operand for pending binary operation
    PendingOperator: TOperatorType;// Operator waiting for execution
    IsNewInput: Boolean;           // Whether the next digit input should start a new number
    Expression: string;            // Current Collected Expression
  end;
*)
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
