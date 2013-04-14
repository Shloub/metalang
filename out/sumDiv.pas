program sumDiv;

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
function read_int() : integer;
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

function sumdiv(n : integer) : integer;
var
  i : integer;
  out_ : integer;
begin
  { On désire renvoyer la somme des diviseurs }
  out_ := 0;
  { On déclare un entier qui contiendra la somme }
  for i := 1 to  n do
  begin
    { La boucle : i est le diviseur potentiel}
    if (n Mod i) = 0
    then
      begin
        { Si i divise }
        out_ := out_ + i;
        { On incrémente }
      end
    else
      begin
        { nop }
      end;
  end;
  exit(out_);
  {On renvoie out}
end;


var
  b : integer;
  n : integer;
begin
  { Programme principal }
  n := 0;
  n := read_int();
  { Lecture de l'entier }
  b := sumdiv(n);
  write(b);
end.


