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

type w = array of Longint;
function read_int_line(n : Longint) : w;
var
  i : Longint;
  t : Longint;
  tab : w;
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

type ba = array of w;
function read_int_matrix(x : Longint; y : Longint) : ba;
var
  d : w;
  e : Longint;
  f : w;
  g : Longint;
  h : Longint;
  tab : ba;
  z : Longint;
begin
  SetLength(tab, y);
  for z := 0 to  y - 1 do
  begin
    e := x;
    SetLength(f, e);
    for g := 0 to  e - 1 do
    begin
      h := 0;
      h := read_int_();
      skip();
      f[g] := h;
    end;
    d := f;
    tab[z] := d;
  end;
  exit(tab);
end;

function find(n : Longint; m : ba; x : Longint; y : Longint; dx : Longint; dy : Longint) : Longint;
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
  directions : array of tuple_int_int;
  dx : Longint;
  dy : Longint;
  i : Longint;
  j : Longint;
  k : tuple_int_int;
  l : tuple_int_int;
  m : ba;
  max_ : Longint;
  o : tuple_int_int;
  p : tuple_int_int;
  q : tuple_int_int;
  r : tuple_int_int;
  s : tuple_int_int;
  u : tuple_int_int;
  v : tuple_int_int;
  x : Longint;
  y : Longint;
begin
  c := 8;
  SetLength(directions, c);
  for i := 0 to  c - 1 do
  begin
    if i = 0 then
      begin
        new(v);
        v^.tuple_int_int_field_0 := 0;
        v^.tuple_int_int_field_1 := 1;
        directions[i] := v;
      end
    else if i = 1 then
      begin
        new(u);
        u^.tuple_int_int_field_0 := 1;
        u^.tuple_int_int_field_1 := 0;
        directions[i] := u;
      end
    else if i = 2 then
      begin
        new(s);
        s^.tuple_int_int_field_0 := 0;
        s^.tuple_int_int_field_1 := -1;
        directions[i] := s;
      end
    else if i = 3 then
      begin
        new(r);
        r^.tuple_int_int_field_0 := -1;
        r^.tuple_int_int_field_1 := 0;
        directions[i] := r;
      end
    else if i = 4 then
      begin
        new(q);
        q^.tuple_int_int_field_0 := 1;
        q^.tuple_int_int_field_1 := 1;
        directions[i] := q;
      end
    else if i = 5 then
      begin
        new(p);
        p^.tuple_int_int_field_0 := 1;
        p^.tuple_int_int_field_1 := -1;
        directions[i] := p;
      end
    else if i = 6
    then
      begin
        new(o);
        o^.tuple_int_int_field_0 := -1;
        o^.tuple_int_int_field_1 := 1;
        directions[i] := o;
      end
    else
      begin
        new(l);
        l^.tuple_int_int_field_0 := -1;
        l^.tuple_int_int_field_1 := -1;
        directions[i] := l;
      end;;;;;;;
  end;
  max_ := 0;
  m := read_int_matrix(20, 20);
  for j := 0 to  7 do
  begin
    k := directions[j];
    dx := k^.tuple_int_int_field_0;
    dy := k^.tuple_int_int_field_1;
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


