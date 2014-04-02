program aaa_integer;



var
  a : Longint;
  b : Longint;
  c : Longint;
  d : Longint;
  e : Longint;
  f : Longint;
  g : Longint;
  h : Longint;
  i : Longint;
begin
  i := 0;
  i := i - 1;
  Write(i);
  Write(''#10'');
  i := i + 55;
  Write(i);
  Write(''#10'');
  i := i * 13;
  Write(i);
  Write(''#10'');
  i := i Div 2;
  Write(i);
  Write(''#10'');
  i := i + 1;
  Write(i);
  Write(''#10'');
  i := i Div 3;
  Write(i);
  Write(''#10'');
  i := i - 1;
  Write(i);
  Write(''#10'');
  {
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
}
  a := 117 Div 17;
  Write(a);
  Write(''#10'');
  b := 117 Div -17;
  Write(b);
  Write(''#10'');
  c := -117 Div 17;
  Write(c);
  Write(''#10'');
  d := -117 Div -17;
  Write(d);
  Write(''#10'');
  e := 117 Mod 17;
  Write(e);
  Write(''#10'');
  f := 117 Mod -17;
  Write(f);
  Write(''#10'');
  g := -117 Mod 17;
  Write(g);
  Write(''#10'');
  h := -117 Mod -17;
  Write(h);
  Write(''#10'');
end.


