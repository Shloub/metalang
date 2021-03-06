program aaa_missing;

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

{
  Ce test a été généré par Metalang.
}
type b = array of boolean;
type c = array of Longint;
function result(len : Longint; tab : c) : Longint;
var
  i : Longint;
  i1 : Longint;
  i2 : Longint;
  tab2 : b;
begin
  SetLength(tab2, len);
  for i := 0 to  len - 1 do
  begin
    tab2[i] := false;
  end;
  for i1 := 0 to  len - 1 do
  begin
    Write(tab[i1]);
    Write(' ');
    tab2[tab[i1]] := true;
  end;
  Write(''#10'');
  for i2 := 0 to  len - 1 do
  begin
    if not(tab2[i2])
    then
      begin
        exit(i2);
      end;
  end;
  exit(-1);
end;


var
  a : Longint;
  len : Longint;
  tab : c;
begin
  len := read_int_();
  skip();
  Write(len);
  Write(''#10'');
  SetLength(tab, len);
  for a := 0 to  len - 1 do
  begin
    tab[a] := read_int_();
    skip();
  end;
  Write(result(len, tab));
  Write(''#10'');
end.


