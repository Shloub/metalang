program aaa_10stringsarray;

type
    toto=^toto_r;
    toto_r = record
      s : string;
      v : Longint;
    end;

function idstring(s : string) : string;
begin
  exit(s);
end;

procedure printstring(s : string);
begin
  Write(idstring(s));
  Write(''#10'');
end;

procedure print_toto(t : toto);
begin
  Write(t^.s);
  Write(' = ');
  Write(t^.v);
  Write(''#10'');
end;

type b = array of string;

var
  a : toto;
  i : Longint;
  j : Longint;
  tab : b;
begin
  SetLength(tab, 2);
  for i := 0 to  1 do
  begin
    tab[i] := idstring('chaine de test');
  end;
  for j := 0 to  1 do
  begin
    printstring(idstring(tab[j]));
  end;
  new(a);
  a^.s := 'one';
  a^.v := 1;
  print_toto(a);
end.


