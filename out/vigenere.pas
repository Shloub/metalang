program vigenere;

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
function read_int_() : integer;
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



function position_alphabet(c : char) : integer;
var
  i : integer;
begin
  i := ord(c);
  if (i <= ord(#90)) and (i >= ord(#65)) then
    begin
      exit(i - ord(#65));
    end
  else if (i <= ord(#122)) and (i >= ord(#97))
  then
    begin
      exit(i - ord(#97));
    end
  else
    begin
      exit(-1);
    end;;
end;

function of_position_alphabet(c : integer) : char;
begin
  exit(chr(c + ord(#97)));
end;

type b = array of char;
procedure crypte(taille_cle : integer; cle : b; taille : integer; message : b);
var
  addon : integer;
  i : integer;
  lettre : integer;
  new_ : integer;
begin
  for i := 0 to  taille - 1 do
  begin
    lettre := position_alphabet(message[i]);
    if lettre <> -1
    then
      begin
        addon := position_alphabet(cle[i Mod taille_cle]);
        new_ := (addon + lettre) Mod 26;
        message[i] := of_position_alphabet(new_);
      end;
  end;
end;


var
  a : char;
  cle : b;
  i : integer;
  index : integer;
  index2 : integer;
  message : b;
  out2 : char;
  out_ : char;
  taille : integer;
  taille_cle : integer;
begin
  taille_cle := 0;
  taille_cle := read_int_();
  skip();
  SetLength(cle, taille_cle);
  for index := 0 to  taille_cle - 1 do
  begin
    out_ := #95;
    out_ := read_char_();
    cle[index] := out_;
  end;
  skip();
  taille := 0;
  taille := read_int_();
  skip();
  SetLength(message, taille);
  for index2 := 0 to  taille - 1 do
  begin
    out2 := #95;
    out2 := read_char_();
    message[index2] := out2;
  end;
  crypte(taille_cle, cle, taille, message);
  for i := 0 to  taille - 1 do
  begin
    a := message[i];
    Write(a);
  end;
  Write(''#10'');
end.


