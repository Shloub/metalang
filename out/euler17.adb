
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler17 is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

  one_to_twenty : Integer;
  one_to_thirty : Integer;
  one_to_ten : Integer;
  one_to_sixty : Integer;
  one_to_seventy : Integer;
  one_to_ninety_nine : Integer;
  one_to_ninety : Integer;
  one_to_nine : Integer;
  one_to_forty : Integer;
  one_to_fifty : Integer;
  one_to_eighty : Integer;
begin
  PInt(3 + 3 + 5 + 4 + 4);
  PString("" & Character'Val(10));
  one_to_nine := 3 + 3 + 5 + 4 + 4 + 3 + 5 + 5 + 4;
  PInt(one_to_nine);
  PString("" & Character'Val(10));
  one_to_ten := one_to_nine + 3;
  one_to_twenty := one_to_ten + 6 + 6 + 8 + 8 + 7 + 7 + 9 + 8 + 8 + 6;
  one_to_thirty := one_to_twenty + 6 * 9 + one_to_nine + 6;
  one_to_forty := one_to_thirty + 6 * 9 + one_to_nine + 5;
  one_to_fifty := one_to_forty + 5 * 9 + one_to_nine + 5;
  one_to_sixty := one_to_fifty + 5 * 9 + one_to_nine + 5;
  one_to_seventy := one_to_sixty + 5 * 9 + one_to_nine + 7;
  one_to_eighty := one_to_seventy + 7 * 9 + one_to_nine + 6;
  one_to_ninety := one_to_eighty + 6 * 9 + one_to_nine + 6;
  one_to_ninety_nine := one_to_ninety + 6 * 9 + one_to_nine;
  PInt(one_to_ninety_nine);
  PString("" & Character'Val(10));
  PInt(100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 3 +
  8);
  PString("" & Character'Val(10));
end;
