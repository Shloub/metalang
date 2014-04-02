program triangles;

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

{ Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
}
type e = array of array of Longint;
function find0(len : Longint; tab : e; cache : e; x : Longint; y : Longint) : Longint;
var
  out0 : Longint;
  out1 : Longint;
  result : Longint;
begin
  {
	Cette fonction est récursive
	}
  if y = (len - 1) then
    begin
      exit(tab[y][x]);
    end
  else if x > y then
    begin
      exit(100000);
    end
  else if cache[y][x] <> 0
  then
    begin
      exit(cache[y][x]);
    end;;;
  result := 0;
  out0 := find0(len, tab, cache, x, y + 1);
  out1 := find0(len, tab, cache, x + 1, y + 1);
  if out0 < out1
  then
    begin
      result := out0 + tab[y][x];
    end
  else
    begin
      result := out1 + tab[y][x];
    end;
  cache[y][y] := result;
  exit(result);
end;

type f = array of Longint;
function find(len : Longint; tab : e) : Longint;
var
  a : Longint;
  i : Longint;
  j : Longint;
  tab2 : e;
  tab3 : f;
begin
  SetLength(tab2, len);
  for i := 0 to  len - 1 do
  begin
    a := i + 1;
    SetLength(tab3, a);
    for j := 0 to  a - 1 do
    begin
      tab3[j] := 0;
    end;
    tab2[i] := tab3;
  end;
  exit(find0(len, tab, tab2, 0, 0));
end;


var
  b : Longint;
  c : Longint;
  d : Longint;
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  len : Longint;
  tab : e;
  tab2 : f;
  tmp : Longint;
begin
  len := 0;
  len := read_int_();
  skip();
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    b := i + 1;
    SetLength(tab2, b);
    for j := 0 to  b - 1 do
    begin
      tmp := 0;
      tmp := read_int_();
      skip();
      tab2[j] := tmp;
    end;
    tab[i] := tab2;
  end;
  c := find(len, tab);
  Write(c);
  for k := 0 to  len - 1 do
  begin
    for l := 0 to  k do
    begin
      d := tab[k][l];
      Write(d);
    end;
    Write(''#10'');
  end;
end.


