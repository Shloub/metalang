program bigints;

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
function read_char_() : char;
var
   c : char;
begin
   c := read_char_aux();
   skip_char();
   read_char_ := c;
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


function max2(a : integer; b : integer) : integer;
begin
  if a > b
  then
    begin
      exit(a);
    end;
  exit(b);
end;

type
    bigint=^bigint_r;
    bigint_r = record
      sign : boolean;
      chiffres_len : integer;
      chiffres : array of integer;
    end;

function read_big_int() : bigint;
var
  c : char;
  chiffres : array of integer;
  d : integer;
  i : integer;
  len : integer;
  out_ : bigint;
  sign : char;
  tmp : integer;
begin
  Write('read_big_int');
  len := 0;
  len := read_int_();
  skip();
  Write(len);
  Write('=len ');
  sign := #95;
  sign := read_char_();
  Write(sign);
  Write('=sign'#10'');
  SetLength(chiffres, len);
  for d := 0 to  len - 1 do
  begin
    c := #95;
    c := read_char_();
    Write(c);
    Write('=c'#10'');
    chiffres[d] := ord(c) - ord(#48);
  end;
  for i := 0 to  len Div 2 do
  begin
    tmp := chiffres[i];
    chiffres[i] := chiffres[len - 1 - i];
    chiffres[len - 1 - i] := tmp;
  end;
  skip();
  new(out_);
  out_^.sign := sign
  =
  #43;
  out_^.chiffres_len := len;
  out_^.chiffres := chiffres;
  exit(out_);
end;

procedure print_big_int(a : bigint);
var
  e : integer;
  i : integer;
begin
  if a^.sign
  then
    begin
      Write('+');
    end
  else
    begin
      Write('-');
    end;
  for i := 0 to  a^.chiffres_len - 1 do
  begin
    e := a^.chiffres[i];
    Write(e);
  end;
end;

function neg_big_int(a : bigint) : bigint;
var
  out_ : bigint;
begin
  new(out_);
  out_^.sign := not a^.sign;
  out_^.chiffres_len := a^.chiffres_len;
  out_^.chiffres := a^.chiffres;
  exit(out_);
end;

function add_big_int(a : bigint; b : bigint) : bigint;
var
  chiffres : array of integer;
  i : integer;
  len : integer;
  out_ : bigint;
  retenue : integer;
  sign : boolean;
  tmp : integer;
begin
  len := max2(a^.chiffres_len, b^.chiffres_len) + 1;
  retenue := 0;
  sign := true;
  SetLength(chiffres, len);
  for i := 0 to  len - 1 do
  begin
    tmp := retenue;
    if i < a^.chiffres_len
    then
      begin
        tmp := tmp + a^.chiffres[i];
      end;
    if i < b^.chiffres_len
    then
      begin
        tmp := tmp + b^.chiffres[i];
      end;
    retenue := tmp Div 10;
    chiffres[i] := tmp Mod 10;
  end;
  new(out_);
  out_^.sign := sign;
  out_^.chiffres_len := len;
  out_^.chiffres := chiffres;
  exit(out_);
end;

{
def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end
}

var
  a : bigint;
  b : bigint;
begin
  a := read_big_int();
  b := read_big_int();
  print_big_int(add_big_int(a, b));
end.


