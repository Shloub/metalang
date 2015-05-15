program euler52;

function chiffre_sort(a : Longint) : Longint;
var
  b : Longint;
  c : Longint;
  d : Longint;
  e : Longint;
begin
  if a < 10
  then
    begin
      exit(a);
    end
  else
    begin
      b := chiffre_sort(a Div 10);
      c := a Mod 10;
      d := b Mod 10;
      e := b Div 10;
      if c < d
      then
        begin
          exit(c + b * 10);
        end
      else
        begin
          exit(d + chiffre_sort(c + e * 10) * 10);
        end;
    end;
end;

function same_numbers(a : Longint; b : Longint; c : Longint; d : Longint; e : Longint; f : Longint) : boolean;
var
  ca : Longint;
begin
  ca := chiffre_sort(a);
  exit((ca = chiffre_sort(b)) and (ca = chiffre_sort(c)) and (ca = chiffre_sort(d)) and (ca = chiffre_sort(e)) and (ca = chiffre_sort(f)));
end;


var
  num : Longint;
begin
  num := 142857;
  if same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5)
  then
    begin
      Write(num);
      Write(' ');
      Write(num * 2);
      Write(' ');
      Write(num * 3);
      Write(' ');
      Write(num * 4);
      Write(' ');
      Write(num * 5);
      Write(' ');
      Write(num * 6);
      Write(''#10'');
    end;
end.


