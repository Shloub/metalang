program longest_increasing_subsequence;

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

type f = array of Longint;
function dichofind(len : Longint; tab : f; tofind : Longint; a : Longint; b : Longint) : Longint;
var
  c : Longint;
begin
  if a >= b - 1
  then
    begin
      exit(a);
    end
  else
    begin
      c := (a + b) Div 2;
      if tab[c] < tofind
      then
        begin
          exit(dichofind(len, tab, tofind, c, b));
        end
      else
        begin
          exit(dichofind(len, tab, tofind, a, c));
        end;
    end;
end;

function process(len : Longint; tab : f) : Longint;
var
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  m : Longint;
  size : f;
begin
  SetLength(size, len);
  for j := 0 to  len - 1 do
  begin
    if j = 0
    then
      begin
        size[j] := 0;
      end
    else
      begin
        size[j] := len * 2;
      end;
  end;
  for i := 0 to  len - 1 do
  begin
    k := dichofind(len, size, tab[i], 0, len - 1);
    if size[k + 1] > tab[i]
    then
      begin
        size[k + 1] := tab[i];
      end;
  end;
  for l := 0 to  len - 1 do
  begin
    Write(size[l]);
    Write(' ');
  end;
  for m := 0 to  len - 1 do
  begin
    k := len - 1 - m;
    if size[k] <> len * 2
    then
      begin
        exit(k);
      end;
  end;
  exit(0);
end;


var
  d : f;
  e : Longint;
  i : Longint;
  len : Longint;
  n : Longint;
begin
  n := read_int_();
  skip();
  for i := 1 to  n do
  begin
    len := read_int_();
    skip();
    SetLength(d, len);
    for e := 0 to  len - 1 do
    begin
      d[e] := read_int_();
      skip();
    end;
    Write(process(len, d));
    Write(''#10'');
  end;
end.


