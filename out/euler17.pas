program euler17;



var
  one_to_eighty : Longint;
  one_to_fifty : Longint;
  one_to_forty : Longint;
  one_to_nine : Longint;
  one_to_ninety : Longint;
  one_to_ninety_nine : Longint;
  one_to_seventy : Longint;
  one_to_sixty : Longint;
  one_to_ten : Longint;
  one_to_thirty : Longint;
  one_to_twenty : Longint;
begin
  Write(3 + 16);
  Write(''#10'');
  one_to_nine := 3 + 33;
  Write(one_to_nine);
  Write(''#10'');
  one_to_ten := one_to_nine + 3;
  one_to_twenty := one_to_ten + 73;
  one_to_thirty := one_to_twenty + 6 * 9 + one_to_nine + 6;
  one_to_forty := one_to_thirty + 6 * 9 + one_to_nine + 5;
  one_to_fifty := one_to_forty + 5 * 9 + one_to_nine + 5;
  one_to_sixty := one_to_fifty + 5 * 9 + one_to_nine + 5;
  one_to_seventy := one_to_sixty + 5 * 9 + one_to_nine + 7;
  one_to_eighty := one_to_seventy + 7 * 9 + one_to_nine + 6;
  one_to_ninety := one_to_eighty + 6 * 9 + one_to_nine + 6;
  one_to_ninety_nine := one_to_ninety + 6 * 9 + one_to_nine;
  Write(one_to_ninety_nine);
  Write(''#10'');
  Write(100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 11);
  Write(''#10'');
end.


