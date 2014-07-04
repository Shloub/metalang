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

function max2(a : Longint; b : Longint) : Longint;
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

type q = array of Longint;
function read_int_line(n : Longint) : q;
var
  i : Longint;
  t : Longint;
  tab : q;
begin
  SetLength(tab, n);
  for i := 0 to  n - 1 do
  begin
    t := 0;
    t := read_int_();
    skip();
    tab[i] := t;
  end;
  exit(tab);
end;

type r = array of q;
function read_int_matrix(x : Longint; y : Longint) : r;
var
  tab : r;
  z : Longint;
begin
  SetLength(tab, y);
  for z := 0 to  y - 1 do
  begin
    tab[z] := read_int_line(x);
  end;
  exit(tab);
end;

function find(n : Longint; m : r; x : Longint; y : Longint; dx : Longint; dy : Longint) : Longint;
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


var
  c : Longint;
  d : tuple_int_int;
  directions : array of tuple_int_int;
  dx : Longint;
  dy : Longint;
  e : tuple_int_int;
  f : tuple_int_int;
  g : tuple_int_int;
  h : tuple_int_int;
  i : Longint;
  j : Longint;
  k : tuple_int_int;
  l : tuple_int_int;
  m : r;
  max_ : Longint;
  o : tuple_int_int;
  p : tuple_int_int;
  x : Longint;
  y : Longint;
begin
  c := 8;
  SetLength(directions, c);
  for i := 0 to  c - 1 do
  begin
    if i = 0 then
      begin
        new(p);
        p^.tuple_int_int_field_0 := 0;
        p^.tuple_int_int_field_1 := 1;
        directions[i] := p;
      end
    else if i = 1 then
      begin
        new(o);
        o^.tuple_int_int_field_0 := 1;
        o^.tuple_int_int_field_1 := 0;
        directions[i] := o;
      end
    else if i = 2 then
      begin
        new(l);
        l^.tuple_int_int_field_0 := 0;
        l^.tuple_int_int_field_1 := -1;
        directions[i] := l;
      end
    else if i = 3 then
      begin
        new(k);
        k^.tuple_int_int_field_0 := -1;
        k^.tuple_int_int_field_1 := 0;
        directions[i] := k;
      end
    else if i = 4 then
      begin
        new(h);
        h^.tuple_int_int_field_0 := 1;
        h^.tuple_int_int_field_1 := 1;
        directions[i] := h;
      end
    else if i = 5 then
      begin
        new(g);
        g^.tuple_int_int_field_0 := 1;
        g^.tuple_int_int_field_1 := -1;
        directions[i] := g;
      end
    else if i = 6
    then
      begin
        new(f);
        f^.tuple_int_int_field_0 := -1;
        f^.tuple_int_int_field_1 := 1;
        directions[i] := f;
      end
    else
      begin
        new(e);
        e^.tuple_int_int_field_0 := -1;
        e^.tuple_int_int_field_1 := -1;
        directions[i] := e;
      end;;;;;;;
  end;
  max_ := 0;
  m := read_int_matrix(20, 20);
  for j := 0 to  7 do
  begin
    d := directions[j];
    dx := d^.tuple_int_int_field_0;
    dy := d^.tuple_int_int_field_1;
    for x := 0 to  19 do
    begin
      for y := 0 to  19 do
      begin
        max_ := max2(max_, find(4, m, x, y, dx, dy));
      end;
    end;
  end;
  Write(max_);
  Write(''#10'');
end.


