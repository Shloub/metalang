program euler11;

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

function max2_(a : Longint; b : Longint) : Longint;
begin
  if a > b
  then
    begin
      exit(a);
    end
  else
    begin
      exit(b);
    end;
end;

type bi = array of Longint;
type bj = array of array of Longint;
function find(n : Longint; m : bj; x : Longint; y : Longint; dx : Longint; dy : Longint) : Longint;
begin
  if (x < 0) or (x = 20) or (y < 0) or (y = 20) then
    begin
      exit(-1);
    end
  else if n = 0
  then
    begin
      exit(1);
    end
  else
    begin
      exit(m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy));
    end;;
end;

type
    tuple_int_int=^tuple_int_int_r;
    tuple_int_int_r = record
      tuple_int_int_field_0 : Longint;
      tuple_int_int_field_1 : Longint;
    end;

type bk = array of tuple_int_int;

var
  ba : tuple_int_int;
  bb : tuple_int_int;
  bc : tuple_int_int;
  bd : tuple_int_int;
  be : tuple_int_int;
  bf : tuple_int_int;
  bg : tuple_int_int;
  bh : tuple_int_int;
  directions : bk;
  dx : Longint;
  dy : Longint;
  h : Longint;
  i : Longint;
  j : Longint;
  m : bj;
  max0 : Longint;
  o : Longint;
  q : Longint;
  r : Longint;
  s : bi;
  u : Longint;
  v : Longint;
  w : tuple_int_int;
  x : Longint;
  y : Longint;
begin
  SetLength(directions, 8);
  for i := 0 to  8 - 1 do
  begin
    if i = 0 then
      begin
        new(bh);
        bh^.tuple_int_int_field_0 := 0;
        bh^.tuple_int_int_field_1 := 1;
        directions[i] := bh;
      end
    else if i = 1 then
      begin
        new(bg);
        bg^.tuple_int_int_field_0 := 1;
        bg^.tuple_int_int_field_1 := 0;
        directions[i] := bg;
      end
    else if i = 2 then
      begin
        new(bf);
        bf^.tuple_int_int_field_0 := 0;
        bf^.tuple_int_int_field_1 := -1;
        directions[i] := bf;
      end
    else if i = 3 then
      begin
        new(be);
        be^.tuple_int_int_field_0 := -1;
        be^.tuple_int_int_field_1 := 0;
        directions[i] := be;
      end
    else if i = 4 then
      begin
        new(bd);
        bd^.tuple_int_int_field_0 := 1;
        bd^.tuple_int_int_field_1 := 1;
        directions[i] := bd;
      end
    else if i = 5 then
      begin
        new(bc);
        bc^.tuple_int_int_field_0 := 1;
        bc^.tuple_int_int_field_1 := -1;
        directions[i] := bc;
      end
    else if i = 6
    then
      begin
        new(bb);
        bb^.tuple_int_int_field_0 := -1;
        bb^.tuple_int_int_field_1 := 1;
        directions[i] := bb;
      end
    else
      begin
        new(ba);
        ba^.tuple_int_int_field_0 := -1;
        ba^.tuple_int_int_field_1 := -1;
        directions[i] := ba;
      end;;;;;;;
  end;
  max0 := 0;
  h := 20;
  SetLength(m, 20);
  for o := 0 to  20 - 1 do
  begin
    SetLength(s, h);
    for q := 0 to  h - 1 do
    begin
      r := read_int_();
      skip();
      s[q] := r;
    end;
    m[o] := s;
  end;
  for j := 0 to  7 do
  begin
    w := directions[j];
    dx := w^.tuple_int_int_field_0;
    dy := w^.tuple_int_int_field_1;
    for x := 0 to  19 do
    begin
      for y := 0 to  19 do
      begin
        v := find(4, m, x, y, dx, dy);
        u := max2_(max0, v);
        max0 := u;
      end;
    end;
  end;
  Write(max0);
  Write(''#10'');
end.


