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
function read_int_() : integer;
var
   c    : char;
   i    : integer;
   sign :  integer;
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
      foo : integer;
      bar : integer;
      blah : integer;
    end;

function mktoto(v1 : integer) : toto;
var
  t_ : toto;
begin
  new(t_);
  t_^.foo := v1;
  t_^.bar := 0;
  t_^.blah := 0;
  exit(t_);
end;

type d = array of toto;
function result(t_ : d; len : integer) : integer;
var
  j : integer;
  out_ : integer;
begin
  out_ := 0;
  for j := 0 to  len - 1 do
  begin
    t_[j]^.blah := t_[j]^.blah + 1;
    out_ := out_ + t_[j]^.foo + t_[j]^.blah * t_[j]^.bar + t_[j]^.bar * t_[j]^.foo;
  end;
  exit(out_);
end;


var
  a : integer;
  b : integer;
  c : integer;
  i : integer;
  t_ : d;
begin
  a := 4;
  SetLength(t_, a);
  for i := 0 to  a - 1 do
  begin
    t_[i] := mktoto(i);
  end;
  t_[0]^.bar := read_int_();
  skip();
  t_[1]^.blah := read_int_();
  b := result(t_, 4);
  Write(b);
  c := t_[2]^.blah;
  Write(c);
end.


