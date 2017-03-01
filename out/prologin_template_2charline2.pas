program prologin_template_2charline2;

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


type c = array of char;
function programme_candidat(tableau1 : c; taille1 : Longint; tableau2 : c; taille2 : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  out0 : Longint;
begin
  out0 := 0;
  for i := 0 to  taille1 - 1 do
  begin
    out0 := out0 + ord(tableau1[i]) * i;
    Write(tableau1[i]);
  end;
  Write('--'#10'');
  for j := 0 to  taille2 - 1 do
  begin
    out0 := out0 + ord(tableau2[j]) * j * 100;
    Write(tableau2[j]);
  end;
  Write('--'#10'');
  exit(out0);
end;


var
  a : Longint;
  b : Longint;
  tableau1 : c;
  tableau2 : c;
  taille1 : Longint;
  taille2 : Longint;
begin
  taille1 := read_int_();
  skip();
  taille2 := read_int_();
  skip();
  SetLength(tableau1, taille1);
  for a := 0 to  taille1 - 1 do
  begin
    tableau1[a] := read_char_();
  end;
  skip();
  SetLength(tableau2, taille2);
  for b := 0 to  taille2 - 1 do
  begin
    tableau2[b] := read_char_();
  end;
  skip();
  Write(programme_candidat(tableau1, taille1, tableau2, taille2));
  Write(''#10'');
end.


