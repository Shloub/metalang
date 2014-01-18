program aaa_integer;

Type lng = (
  LANG_C,
   LANG_Pas,
   LANG_Cc,
   LANG_Cs,
   LANG_Java,
   LANG_Js,
   LANG_Ml,
   LANG_Php,
   LANG_Rb,
   LANG_Py,
   LANG_Tex,
   LANG_Metalang);


var
  i : integer;
begin
  i := 0;
  i := i + 1;
  write(i);
  i := i + 55;
  write(i);
  i := i * 13;
  write(i);
  i := i Div 2;
  write(i);
  i := i + 1;
  write(i);
  i := i Div 3;
  write(i);
  i := i - 1;
  write(i);
end.


