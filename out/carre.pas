program carre;
Uses math;

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


type g = array of Longint;
type h = array of g;

var
  d : Longint;
  e : g;
  f : Longint;
  ix : Longint;
  iy : Longint;
  jx : Longint;
  jy : Longint;
  tab : h;
  x : Longint;
  y : Longint;
begin
  x := read_int_();
  skip();
  y := read_int_();
  skip();
  SetLength(tab, y);
  for d := 0 to  y - 1 do
  begin
    SetLength(e, x);
    for f := 0 to  x - 1 do
    begin
      e[f] := read_int_();
      skip();
    end;
    tab[d] := e;
  end;
  for ix := 1 to  x - 1 do
  begin
    for iy := 1 to  y - 1 do
    begin
      if tab[iy][ix] = 1
      then
        begin
          tab[iy][ix] := Min(Min(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1;
        end;
    end;
  end;
  for jy := 0 to  y - 1 do
  begin
    for jx := 0 to  x - 1 do
    begin
      Write(tab[jy][jx]);
      Write(' ');
    end;
    Write(''#10'');
  end;
end.


