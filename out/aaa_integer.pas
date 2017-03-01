program aaa_integer;



var
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
  Write(117 Div 17);
  Write(''#10'');
  Write(117 Div -17);
  Write(''#10'');
  Write(-117 Div 17);
  Write(''#10'');
  Write(-117 Div -17);
  Write(''#10'');
  Write(117 Mod 17);
  Write(''#10'');
  Write(117 Mod -17);
  Write(''#10'');
  Write(-117 Mod 17);
  Write(''#10'');
  Write(-117 Mod -17);
  Write(''#10'');
end.


