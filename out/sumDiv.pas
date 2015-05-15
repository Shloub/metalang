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

procedure foo();
var
  a : Longint;
begin
  a := 0;
  { test }
  a := a + 1;
  { test 2 }
end;

procedure foo2();
begin
  
end;

procedure foo3();
begin
  if 1 = 1
  then
    begin
      
    end;
end;

function sumdiv(n : Longint) : Longint;
var
  i : Longint;
  out0 : Longint;
begin
  { On désire renvoyer la somme des diviseurs }
  out0 := 0;
  { On déclare un entier qui contiendra la somme }
  for i := 1 to  n do
  begin
    { La boucle : i est le diviseur potentiel}
    if n Mod i = 0
    then
      begin
        { Si i divise }
        out0 := out0 + i;
        { On incrémente }
      end
    else
      begin
        { nop }
      end;
  end;
  exit(out0);
  {On renvoie out}
end;


var
  n : Longint;
begin
  { Programme principal }
  n := 0;
  n := read_int_();
  { Lecture de l'entier }
  Write(sumdiv(n));
end.


