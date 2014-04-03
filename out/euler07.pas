program euler07;

type c = array of Longint;
function divisible(n : Longint; t : c; size : Longint) : boolean;
var
  i : Longint;
begin
  for i := 0 to  size - 1 do
  begin
    if (n Mod t[i]) = 0
    then
      begin
        exit(true);
      end;
  end;
  exit(false);
end;

function find(n : Longint; t : c; used : Longint; nth : Longint) : Longint;
begin
  while used <> nth do
  begin
    if divisible(n, t, used)
    then
      begin
        n := n + 1;
      end
    else
      begin
        t[used] := n;
        n := n + 1;
        used := used + 1;
      end;
  end;
  exit(t[used - 1]);
end;


var
  a : Longint;
  b : Longint;
  i : Longint;
  t : c;
begin
  a := 10001;
  SetLength(t, a);
  for i := 0 to  a - 1 do
  begin
    t[i] := 2;
  end;
  b := find(3, t, 1, 10001);
  Write(b);
  Write(''#10'');
end.


