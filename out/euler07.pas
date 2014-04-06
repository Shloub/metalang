program euler07;

type b = array of Longint;
function divisible(n : Longint; t : b; size : Longint) : boolean;
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

function find(n : Longint; t : b; used : Longint; nth : Longint) : Longint;
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
  i : Longint;
  n : Longint;
  t : b;
begin
  n := 10001;
  SetLength(t, n);
  for i := 0 to  n - 1 do
  begin
    t[i] := 2;
  end;
  a := find(3, t, 1, n);
  Write(a);
  Write(''#10'');
end.


