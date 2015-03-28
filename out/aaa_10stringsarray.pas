program aaa_10stringsarray;

{
TODO ajouter un record qui contient des chaines.
}
function idstring(s : string) : string;
begin
  exit(s);
end;

procedure printstring(s : string);
begin
  Write(idstring(s));
  Write(''#10'');
end;

type a = array of string;

var
  i : Longint;
  j : Longint;
  tab : a;
begin
  SetLength(tab, 2);
  for i := 0 to  2 - 1 do
  begin
    tab[i] := idstring('chaine de test');
  end;
  for j := 0 to  1 do
  begin
    printstring(idstring(tab[j]));
  end;
end.


