program pathfindList;


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


type a = array of integer;
function pathfind_aux(cache : a; tab : a; len : integer; pos : integer) : integer;
var
  oneval : integer;
  out_ : integer;
  posval : integer;
begin
  if pos >= (len - 1) then
    begin
      exit(0);
    end
  else if cache[pos] <> -1
  then
    begin
      exit(cache[pos]);
    end
  else
    begin
      cache[pos] := len * 2;
      posval := pathfind_aux(cache, tab, len, tab[pos]);
      oneval := pathfind_aux(cache, tab, len, pos + 1);
      out_ := 0;
      if posval < oneval
      then
        begin
          out_ := 1 + posval;
        end
      else
        begin
          out_ := 1 + oneval;
        end;
      cache[pos] := out_;
      exit(out_);
    end;;
end;

function pathfind(tab : a; len : integer) : integer;
var
  cache : a;
  i : integer;
begin
  SetLength(cache, len);
  for i := 0 to  len - 1 do
  begin
    cache[i] := -1;
  end;
  exit(pathfind_aux(cache, tab, len, 0));
end;


var
  i : integer;
  len : integer;
  result : integer;
  tab : a;
  tmp : integer;
begin
  len := 0;
  len := read_int();
  skip();
  SetLength(tab, len);
  for i := 0 to  len - 1 do
  begin
    tmp := 0;
    tmp := read_int();
    skip();
    tab[i] := tmp;
  end;
  result := pathfind(tab, len);
  write(result);
end.


