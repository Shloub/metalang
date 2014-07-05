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

function read_int() : Longint;
var
  out_ : Longint;
begin
  out_ := 0;
  out_ := read_int_();
  skip();
  exit(out_);
end;

type d = array of char;
function read_char_line(n : Longint) : d;
var
  i : Longint;
  t : char;
  tab : d;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t := #95;
    t := read_char_();
    tab[i] := t;
  end;
  skip();
  exit(tab);
end;

function programme_candidat(tableau1 : d; taille1 : Longint; tableau2 : d; taille2 : Longint) : Longint;
var
  a : char;
  b : char;
  i : Longint;
  j : Longint;
  out_ : Longint;
begin
  out_ := 0;
  for i := 0 to  taille1 - 1 do
  begin
    out_ := out_ + ord(tableau1[i]) * i;
    a := tableau1[i];
    Write(a);
  end;
  Write('--'#10'');
  for j := 0 to  taille2 - 1 do
  begin
    out_ := out_ + ord(tableau2[j]) * j * 100;
    b := tableau2[j];
    Write(b);
  end;
  Write('--'#10'');
  exit(out_);
end;


var
  c : Longint;
  tableau1 : d;
  tableau2 : d;
  taille1 : Longint;
  taille2 : Longint;
begin
  taille1 := read_int();
  taille2 := read_int();
  tableau1 := read_char_line(taille1);
  tableau2 := read_char_line(taille2);
  c := programme_candidat(tableau1, taille1, tableau2, taille2);
  Write(c);
  Write(''#10'');
end.


