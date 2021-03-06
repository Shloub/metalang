program sudoku;

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

{ lit un sudoku sur l'entrée standard }
type a = array of Longint;
function read_sudoku() : a;
var
  i : Longint;
  k : Longint;
  out0 : a;
begin
  SetLength(out0, 9 * 9);
  for i := 0 to  9 * 9 - 1 do
  begin
    k := read_int_();
    skip();
    out0[i] := k;
  end;
  exit(out0);
end;

{ affiche un sudoku }
procedure print_sudoku(sudoku0 : a);
var
  x : Longint;
  y : Longint;
begin
  for y := 0 to  8 do
  begin
    for x := 0 to  8 do
    begin
      Write(sudoku0[x + y * 9]);
      Write(' ');
      if x Mod 3 = 2
      then
        begin
          Write(' ');
        end;
    end;
    Write(''#10'');
    if y Mod 3 = 2
    then
      begin
        Write(''#10'');
      end;
  end;
  Write(''#10'');
end;

{ dit si les variables sont toutes différentes }
{ dit si les variables sont toutes différentes }
{ dit si le sudoku est terminé de remplir }
function sudoku_done(s : a) : boolean;
var
  i : Longint;
begin
  for i := 0 to  80 do
  begin
    if s[i] = 0
    then
      begin
        exit(false);
      end;
  end;
  exit(true);
end;

{ dit si il y a une erreur dans le sudoku }
function sudoku_error(s : a) : boolean;
var
  out1 : boolean;
  out2 : boolean;
  out3 : boolean;
  x : Longint;
begin
  out1 := false;
  for x := 0 to  8 do
  begin
    out1 := out1 or (s[x] <> 0) and (s[x] = s[x + 9]) or (s[x] <> 0) and (s[x] = s[x + 9 * 2]) or (s[x + 9] <> 0) and (s[x + 9] = s[x + 9 * 2]) or (s[x] <> 0) and (s[x] = s[x + 9 * 3]) or (s[x + 9] <> 0) and (s[x + 9] = s[x + 9 * 3]) or (s[x + 9 * 2] <> 0) and (s[x + 9 * 2] = s[x + 9 * 3]) or (s[x] <> 0) and (s[x] = s[x + 9 * 4]) or (s[x + 9] <> 0) and (s[x + 9] = s[x + 9 * 4]) or (s[x + 9 * 2] <> 0) and (s[x + 9 * 2] = s[x + 9 * 4]) or (s[x + 9 * 3] <> 0) and (s[x + 9 * 3] = s[x + 9 * 4]) or (s[x] <> 0) and (s[x] = s[x + 9 * 5]) or (s[x + 9] <> 0) and (s[x + 9] = s[x + 9 * 5]) or (s[x + 9 * 2] <> 0) and (s[x + 9 * 2] = s[x + 9 * 5]) or (s[x + 9 * 3] <> 0) and (s[x + 9 * 3] = s[x + 9 * 5]) or (s[x + 9 * 4] <> 0) and (s[x + 9 * 4] = s[x + 9 * 5]) or (s[x] <> 0) and (s[x] = s[x + 9 * 6]) or (s[x + 9] <> 0) and (s[x + 9] = s[x + 9 * 6]) or (s[x + 9 * 2] <> 0) and (s[x + 9 * 2] = s[x + 9 * 6]) or (s[x + 9 * 3] <> 0) and (s[x + 9 * 3] = s[x + 9 * 6]) or (s[x + 9 * 4] <> 0) and (s[x + 9 * 4] = s[x + 9 * 6]) or (s[x + 9 * 5] <> 0) and (s[x + 9 * 5] = s[x + 9 * 6]) or (s[x] <> 0) and (s[x] = s[x + 9 * 7]) or (s[x + 9] <> 0) and (s[x + 9] = s[x + 9 * 7]) or (s[x + 9 * 2] <> 0) and (s[x + 9 * 2] = s[x + 9 * 7]) or (s[x + 9 * 3] <> 0) and (s[x + 9 * 3] = s[x + 9 * 7]) or (s[x + 9 * 4] <> 0) and (s[x + 9 * 4] = s[x + 9 * 7]) or (s[x + 9 * 5] <> 0) and (s[x + 9 * 5] = s[x + 9 * 7]) or (s[x + 9 * 6] <> 0) and (s[x + 9 * 6] = s[x + 9 * 7]) or (s[x] <> 0) and (s[x] = s[x + 9 * 8]) or (s[x + 9] <> 0) and (s[x + 9] = s[x + 9 * 8]) or (s[x + 9 * 2] <> 0) and (s[x + 9 * 2] = s[x + 9 * 8]) or (s[x + 9 * 3] <> 0) and (s[x + 9 * 3] = s[x + 9 * 8]) or (s[x + 9 * 4] <> 0) and (s[x + 9 * 4] = s[x + 9 * 8]) or (s[x + 9 * 5] <> 0) and (s[x + 9 * 5] = s[x + 9 * 8]) or (s[x + 9 * 6] <> 0) and (s[x + 9 * 6] = s[x + 9 * 8]) or (s[x + 9 * 7] <> 0) and (s[x + 9 * 7] = s[x + 9 * 8]);
  end;
  out2 := false;
  for x := 0 to  8 do
  begin
    out2 := out2 or (s[x * 9] <> 0) and (s[x * 9] = s[x * 9 + 1]) or (s[x * 9] <> 0) and (s[x * 9] = s[x * 9 + 2]) or (s[x * 9 + 1] <> 0) and (s[x * 9 + 1] = s[x * 9 + 2]) or (s[x * 9] <> 0) and (s[x * 9] = s[x * 9 + 3]) or (s[x * 9 + 1] <> 0) and (s[x * 9 + 1] = s[x * 9 + 3]) or (s[x * 9 + 2] <> 0) and (s[x * 9 + 2] = s[x * 9 + 3]) or (s[x * 9] <> 0) and (s[x * 9] = s[x * 9 + 4]) or (s[x * 9 + 1] <> 0) and (s[x * 9 + 1] = s[x * 9 + 4]) or (s[x * 9 + 2] <> 0) and (s[x * 9 + 2] = s[x * 9 + 4]) or (s[x * 9 + 3] <> 0) and (s[x * 9 + 3] = s[x * 9 + 4]) or (s[x * 9] <> 0) and (s[x * 9] = s[x * 9 + 5]) or (s[x * 9 + 1] <> 0) and (s[x * 9 + 1] = s[x * 9 + 5]) or (s[x * 9 + 2] <> 0) and (s[x * 9 + 2] = s[x * 9 + 5]) or (s[x * 9 + 3] <> 0) and (s[x * 9 + 3] = s[x * 9 + 5]) or (s[x * 9 + 4] <> 0) and (s[x * 9 + 4] = s[x * 9 + 5]) or (s[x * 9] <> 0) and (s[x * 9] = s[x * 9 + 6]) or (s[x * 9 + 1] <> 0) and (s[x * 9 + 1] = s[x * 9 + 6]) or (s[x * 9 + 2] <> 0) and (s[x * 9 + 2] = s[x * 9 + 6]) or (s[x * 9 + 3] <> 0) and (s[x * 9 + 3] = s[x * 9 + 6]) or (s[x * 9 + 4] <> 0) and (s[x * 9 + 4] = s[x * 9 + 6]) or (s[x * 9 + 5] <> 0) and (s[x * 9 + 5] = s[x * 9 + 6]) or (s[x * 9] <> 0) and (s[x * 9] = s[x * 9 + 7]) or (s[x * 9 + 1] <> 0) and (s[x * 9 + 1] = s[x * 9 + 7]) or (s[x * 9 + 2] <> 0) and (s[x * 9 + 2] = s[x * 9 + 7]) or (s[x * 9 + 3] <> 0) and (s[x * 9 + 3] = s[x * 9 + 7]) or (s[x * 9 + 4] <> 0) and (s[x * 9 + 4] = s[x * 9 + 7]) or (s[x * 9 + 5] <> 0) and (s[x * 9 + 5] = s[x * 9 + 7]) or (s[x * 9 + 6] <> 0) and (s[x * 9 + 6] = s[x * 9 + 7]) or (s[x * 9] <> 0) and (s[x * 9] = s[x * 9 + 8]) or (s[x * 9 + 1] <> 0) and (s[x * 9 + 1] = s[x * 9 + 8]) or (s[x * 9 + 2] <> 0) and (s[x * 9 + 2] = s[x * 9 + 8]) or (s[x * 9 + 3] <> 0) and (s[x * 9 + 3] = s[x * 9 + 8]) or (s[x * 9 + 4] <> 0) and (s[x * 9 + 4] = s[x * 9 + 8]) or (s[x * 9 + 5] <> 0) and (s[x * 9 + 5] = s[x * 9 + 8]) or (s[x * 9 + 6] <> 0) and (s[x * 9 + 6] = s[x * 9 + 8]) or (s[x * 9 + 7] <> 0) and (s[x * 9 + 7] = s[x * 9 + 8]);
  end;
  out3 := false;
  for x := 0 to  8 do
  begin
    out3 := out3 or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] = s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] = s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] = s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1]) or (s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3] <> 0) and (s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 2]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 2]) or (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] <> 0) and (s[(x Mod 3) * 3 * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 2]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 2]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 2]) or (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2] <> 0) and (s[((x Mod 3) * 3 + 1) * 9 + (x Div 3) * 3 + 2] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 2]) or (s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3] <> 0) and (s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 2]) or (s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1] <> 0) and (s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 1] = s[((x Mod 3) * 3 + 2) * 9 + (x Div 3) * 3 + 2]);
  end;
  exit(out1 or out2 or out3);
end;

{ résout le sudoku}
function solve(sudoku0 : a) : boolean;
var
  i : Longint;
  p : Longint;
begin
  if sudoku_error(sudoku0)
  then
    begin
      exit(false);
    end;
  if sudoku_done(sudoku0)
  then
    begin
      exit(true);
    end;
  for i := 0 to  80 do
  begin
    if sudoku0[i] = 0
    then
      begin
        for p := 1 to  9 do
        begin
          sudoku0[i] := p;
          if solve(sudoku0)
          then
            begin
              exit(true);
            end;
        end;
        sudoku0[i] := 0;
        exit(false);
      end;
  end;
  exit(false);
end;


var
  sudoku0 : a;
begin
  sudoku0 := read_sudoku();
  print_sudoku(sudoku0);
  if solve(sudoku0)
  then
    begin
      print_sudoku(sudoku0);
    end
  else
    begin
      Write('no solution'#10'');
    end;
end.


