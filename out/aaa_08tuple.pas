program aaa_08tuple;

var global_char : char;
var global_has_char : boolean;

procedure skip_char();
begin
   global_has_char := true;
   read(global_char);
end; 
procedure skip();
var
   n : char;
   t : char;
   s : char;
begin
   n := #13;
   t := #10;
   s := #32;
   if not( global_has_char ) then
      skip_char();
   while (global_char = s) or (global_char = n) or (global_char = t) do
   begin
      skip_char();
   end;
end;
function read_char_aux() : char;
begin
   if global_has_char then
      read_char_aux := global_char
   else
   begin
      skip_char();
      read_char_aux := global_char;
   end
end;
function read_int_() : Longint;
var
   c    : char;
   i    : Longint;
   sign :  Longint;
begin
   i := 0;
   c := read_char_aux();
   if c = '-' then begin
      skip_char();
      sign := -1;
   end
   else
      sign := 1;

   repeat
      c := read_char_aux();
      if (ord(c) <=57) and (ord(c) >= 48) then
      begin
         i := i * 10 + ord(c) - 48;
         skip_char();
      end
      else
         exit(i * sign);
   until false;
end;

type tuple_int_int=^tuple_int_int_r;
  tuple_int_int_r = record
    tuple_int_int_field_0 : Longint;
    tuple_int_int_field_1 : Longint;
  end;

type toto=^toto_r;
  toto_r = record
    foo : tuple_int_int;
    bar : Longint;
  end;


var
  a : Longint;
  b : Longint;
  bar_ : Longint;
  c : Longint;
  d : Longint;
  e : tuple_int_int;
  f : tuple_int_int;
  t : toto;
begin
  bar_ := read_int_();
  skip();
  c := read_int_();
  skip();
  d := read_int_();
  skip();
  new(e);
  e^.tuple_int_int_field_0 := c;
  e^.tuple_int_int_field_1 := d;
  new(t);
  t^.foo := e;
  t^.bar := bar_;
  f := t^.foo;
  a := f^.tuple_int_int_field_0;
  b := f^.tuple_int_int_field_1;
  Write(a);
  Write(' ');
  Write(b);
  Write(' ');
  Write(t^.bar);
  Write(''#10'');
end.


