program laby;


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

function read_char() : char;
var
   c : char;
begin
   c := read_char_aux();
   skip_char();
   read_char := c;
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



type
    case_state=^case_state_r;
    case_state_r = record
      left : boolean;
      right : boolean;
      top : boolean;
      bottom : boolean;
      free : boolean;
    end;

type
    laby=^laby_r;
    laby_r = record
      sizeX : integer;
      sizeY : integer;
      cases : array of array of case_state;
    end;

function can_open_right(state : laby; x : integer; y : integer) : boolean;
begin
  exit((x < (state^.sizeX - 1)) and state^.cases[x + 1][y]^.free);
end;

function can_open_left(state : laby; x : integer; y : integer) : boolean;
begin
  exit((x > 0) and state^.cases[x - 1][y]^.free);
end;

function can_open_bottom(state : laby; x : integer; y : integer) : boolean;
begin
  exit((y < (state^.sizeY - 1)) and state^.cases[x][y + 1]^.free);
end;

function can_open_top(state : laby; x : integer; y : integer) : boolean;
begin
  exit((y > 0) and state^.cases[x][y - 1]^.free);
end;

procedure open_left(state : laby; x : integer; y : integer);
begin
  state^.cases[x - 1][y]^.right := false;
  state^.cases[x][y]^.left := false;
  state^.cases[x - 1][y]^.free := false;
  state^.cases[x][y]^.free := false;
end;

procedure open_right(state : laby; x : integer; y : integer);
begin
  state^.cases[x][y]^.right := false;
  state^.cases[x + 1][y]^.left := false;
  state^.cases[x][y]^.free := false;
  state^.cases[x + 1][y]^.free := false;
end;

procedure open_top(state : laby; x : integer; y : integer);
begin
  state^.cases[x][y - 1]^.bottom := false;
  state^.cases[x][y]^.top := false;
  state^.cases[x][y - 1]^.free := false;
  state^.cases[x][y]^.free := false;
end;

procedure open_bottom(state : laby; x : integer; y : integer);
begin
  state^.cases[x][y + 1]^.top := false;
  state^.cases[x][y]^.bottom := false;
  state^.cases[x][y + 1]^.free := false;
  state^.cases[x][y]^.free := false;
end;

type c = array of case_state;
function init(x : integer; y : integer) : laby;
var
  cases : array of c;
  cases_x : c;
  i : integer;
  j : integer;
  out_ : laby;
  reco : case_state;
begin
  SetLength(cases, x);
  for i := 0 to  x - 1 do
  begin
    SetLength(cases_x, y);
    for j := 0 to  y - 1 do
    begin
      new(reco);
      reco^.left := true;
      reco^.right := true;
      reco^.top := true;
      reco^.bottom := true;
      reco^.free := true;
      cases_x[j] := reco;
    end;
    cases[i] := cases_x;
  end;
  new(out_);
  out_^.sizeX := x;
  out_^.sizeY := y;
  out_^.cases := cases;
  exit(out_);
end;

procedure print_lab(l : laby);
var
  x : integer;
  y : integer;
begin
  for x := 0 to  l^.sizeX - 1 do
  begin
    write('__');
  end;
  write(''#10'');
  for y := 0 to  l^.sizeY - 1 do
  begin
    for x := 0 to  l^.sizeX - 1 do
    begin
      if l^.cases[x][y]^.left then
        begin
          if l^.cases[x][y]^.bottom
          then
            begin
              write('|_');
            end
          else
            begin
              write('| ');
            end;
        end
      else if l^.cases[x][y]^.bottom
      then
        begin
          write('__');
        end
      else
        begin
          write('  ');
        end;;
    end;
    write('|'#10'');
  end;
  write(''#10'');
end;

procedure gen(lab : laby; x : integer; y : integer);
var
  b : integer;
  i : integer;
  j : integer;
  k : integer;
  order : array of integer;
begin
  b := 4;
  SetLength(order, b);
  for i := 0 to  b - 1 do
  begin
    order[i] := i;
  end;
  for i := 0 to  2 do
  begin
    j := 4 -
i;
    k := order[i];
    order[i] := order[j];
    order[j] := k;
  end;
  for i := 0 to  3 do
  begin
    if (0 = order[i]) and can_open_left(lab, x, y)
    then
      begin
        open_left(lab, x, y);
        gen(lab, x - 1, y);
      end;
    if (1 = order[i]) and can_open_right(lab, x, y)
    then
      begin
        open_right(lab, x, y);
        gen(lab, x + 1, y);
      end;
    if (2 = order[i]) and can_open_top(lab, x, y)
    then
      begin
        open_top(lab, x, y);
        gen(lab, x, y - 1);
      end;
    if (3 = order[i]) and can_open_bottom(lab, x, y)
    then
      begin
        open_bottom(lab, x, y);
        gen(lab, x, y + 1);
      end;
  end;
end;


var
  lab : laby;
begin
  lab := init(10, 10);
  gen(lab, 0, 0);
  print_lab(lab);
end.


