program loop_unroll;

{
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
}

var
  j : Longint;
begin
  j := 0;
  j := 0;
  Write(j);
  Write(''#10'');
  j := 1;
  Write(j);
  Write(''#10'');
  j := 2;
  Write(j);
  Write(''#10'');
  j := 3;
  Write(j);
  Write(''#10'');
  j := 4;
  Write(j);
  Write(''#10'');
end.


