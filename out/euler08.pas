program euler08;

var global_char : char;
var global_has_char : boolean;

procedure skip_char();
begin
   global_has_char := true;
   read(global_char);
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

function max2(a : Longint; b : Longint) : Longint;
begin
  if a > b
  then
    begin
      exit(a);
    end;
  exit(b);
end;


var
  c : char;
  d : Longint;
  e : char;
  f : Longint;
  g : Longint;
  i : Longint;
  index : Longint;
  j : Longint;
  k : Longint;
  last : array of Longint;
  max_ : Longint;
  nskipdiv : Longint;
begin
  i := 1;
  g := 5;
  SetLength(last, g);
  for j := 0 to  g - 1 do
  begin
    c := #95;
    c := read_char_();
    d := ord(c) - ord(#48);
    i := i * d;
    last[j] := d;
  end;
  max_ := i;
  index := 0;
  nskipdiv := 0;
  for k := 1 to  995 do
  begin
    e := #95;
    e := read_char_();
    f := ord(e) - ord(#48);
    if f = 0
    then
      begin
        i := 1;
        nskipdiv := 4;
      end
    else
      begin
        i := i * f;
        if nskipdiv < 0
        then
          begin
            i := i Div last[index];
          end;
        nskipdiv := nskipdiv - 1;
      end;
    last[index] := f;
    index := (index + 1) Mod 5;
    max_ := max2(max_, i);
  end;
  Write(max_);
  Write(''#10'');
end.


