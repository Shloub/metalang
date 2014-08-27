program cambriolage;

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

type c = array of Longint;
type d = array of c;
function nbPassePartout(n : Longint; passepartout : d; m : Longint; serrures : d) : Longint;
var
  i : Longint;
  max_ancient : Longint;
  max_ancient_pp : Longint;
  max_recent : Longint;
  max_recent_pp : Longint;
  pp : c;
begin
  max_ancient := 0;
  max_recent := 0;
  for i := 0 to  m - 1 do
  begin
    if (serrures[i][0] = -1) and (serrures[i][1] > max_ancient)
    then
      begin
        max_ancient := serrures[i][1];
      end;
    if (serrures[i][0] = 1) and (serrures[i][1] > max_recent)
    then
      begin
        max_recent := serrures[i][1];
      end;
  end;
  max_ancient_pp := 0;
  max_recent_pp := 0;
  for i := 0 to  n - 1 do
  begin
    pp := passepartout[i];
    if (pp[0] >= max_ancient) and (pp[1] >= max_recent)
    then
      begin
        exit(1);
      end;
    max_ancient_pp := max2(max_ancient_pp, pp[0]);
    max_recent_pp := max2(max_recent_pp, pp[1]);
  end;
  if (max_ancient_pp >= max_ancient) and (max_recent_pp >= max_recent)
  then
    begin
      exit(2);
    end
  else
    begin
      exit(0);
    end;
end;


var
  i : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  m : Longint;
  n : Longint;
  out0 : c;
  out1 : c;
  out_ : Longint;
  out__ : Longint;
  passepartout : d;
  serrures : d;
begin
  n := read_int_();
  skip();
  SetLength(passepartout, n);
  for i := 0 to  n - 1 do
  begin
    SetLength(out0, 2);
    for j := 0 to  2 - 1 do
    begin
      out__ := read_int_();
      skip();
      out0[j] := out__;
    end;
    passepartout[i] := out0;
  end;
  m := read_int_();
  skip();
  SetLength(serrures, m);
  for k := 0 to  m - 1 do
  begin
    SetLength(out1, 2);
    for l := 0 to  2 - 1 do
    begin
      out_ := read_int_();
      skip();
      out1[l] := out_;
    end;
    serrures[k] := out1;
  end;
  Write(nbPassePartout(n, passepartout, m, serrures));
end.


