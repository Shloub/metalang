program affect_param;

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

procedure foo(a : integer);
begin
  a := 4;
end;


var
  a : integer;
begin
  a := 0;
  foo(a);
  write(a);
  write(''#10'');
end.


