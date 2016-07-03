program aaa_readints;

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

type e = array of Longint;
type f = array of array of Longint;

var
  a : Longint;
  b : Longint;
  c : e;
  d : Longint;
  i : Longint;
  j : Longint;
  len : Longint;
  tab1 : e;
  tab2 : f;
begin
  len := read_int_();
  skip();
  Write(len);
  Write('=len'#10'');
  SetLength(tab1, len);
  for a := 0 to  len - 1 do
  begin
    tab1[a] := read_int_();
    skip();
  end;
  for i := 0 to  len - 1 do
  begin
    Write(i);
    Write('=>');
    Write(tab1[i]);
    Write(''#10'');
  end;
  len := read_int_();
  skip();
  SetLength(tab2, len - 1);
  for b := 0 to  len - 2 do
  begin
    SetLength(c, len);
    for d := 0 to  len - 1 do
    begin
      c[d] := read_int_();
      skip();
    end;
    tab2[b] := c;
  end;
  for i := 0 to  len - 2 do
  begin
    for j := 0 to  len - 1 do
    begin
      Write(tab2[i][j]);
      Write(' ');
    end;
    Write(''#10'');
  end;
end.


