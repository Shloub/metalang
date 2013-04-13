program brainfuck_compiler;


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




var
  c : integer;
  current_pos : integer;
  d : char;
  i : integer;
  input : char;
  mem : array of integer;
begin
  input := #32;
  current_pos := 500;
  c := 1000;
  SetLength(mem, c);
  for i := 0 to  c - 1 do
  begin
    mem[i] := 0;
  end;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  current_pos := current_pos + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  mem[current_pos] := mem[current_pos] + 1;
  while mem[current_pos] <> 0 do
  begin
    mem[current_pos] := mem[current_pos] - 1;
    current_pos := current_pos - 1;
    mem[current_pos] := mem[current_pos] + 1;
    d := chr(mem[current_pos]);
    write(d);
    current_pos := current_pos + 1;
  end;
end.


