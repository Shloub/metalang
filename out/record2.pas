program record2;

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

type
    toto=^toto_r;
    toto_r = record
      foo : Longint;
      bar : Longint;
      blah : Longint;
    end;

function mktoto(v1 : Longint) : toto;
var
  t : toto;
begin
  new(t);
  t^.foo := v1;
  t^.bar := 0;
  t^.blah := 0;
  exit(t);
end;

function result(t : toto) : Longint;
begin
  t^.blah := t^.blah + 1;
  exit(t^.foo + t^.blah * t^.bar + t^.bar * t^.foo);
end;


var
  a : Longint;
  b : Longint;
  t : toto;
begin
  t := mktoto(4);
  t^.bar := read_int_();
  skip();
  t^.blah := read_int_();
  a := result(t);
  Write(a);
  b := t^.blah;
  Write(b);
end.


