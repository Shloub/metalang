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
function max2_(a : Longint; b : Longint) : Longint;
begin
  if a > b
  then
    begin
      exit(a);
    end
  else
    begin
      exit(b);
    end;
end;

type h = array of Longint;

var
  c : char;
  d : Longint;
  e : char;
  f : Longint;
  i : Longint;
  index : Longint;
  j : Longint;
  k : Longint;
  last : h;
  max0 : Longint;
  nskipdiv : Longint;
begin
  i := 1;
  SetLength(last, 5);
  for j := 0 to  5 - 1 do
  begin
    c := read_char_();
    d := ord(c) - ord(#48);
    i := i * d;
    last[j] := d;
  end;
  max0 := i;
  index := 0;
  nskipdiv := 0;
  for k := 1 to  995 do
  begin
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
    max0 := max2_(max0, i);
  end;
  Write(max0);
  Write(''#10'');
end.


