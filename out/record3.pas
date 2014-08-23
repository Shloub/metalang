program record3;

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

type a = array of toto;
function result(t : a; len : Longint) : Longint;
var
  j : Longint;
  out_ : Longint;
begin
  out_ := 0;
  for j := 0 to  len - 1 do
  begin
    t[j]^.blah := t[j]^.blah + 1;
    out_ := out_ + t[j]^.foo + t[j]^.blah * t[j]^.bar + t[j]^.bar * t[j]^.foo;
  end;
  exit(out_);
end;


var
  i : Longint;
  t : a;
  titi : Longint;
begin
  SetLength(t, 4);
  for i := 0 to  4 - 1 do
  begin
    t[i] := mktoto(i);
  end;
  t[0]^.bar := read_int_();
  skip();
  t[1]^.blah := read_int_();
  titi := result(t, 4);
  Write(titi);
  Write(t[2]^.blah);
end.


