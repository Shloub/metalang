program min3;

function min2_(a : Longint; b : Longint) : Longint;
begin
  if a < b
  then
    begin
      exit(a);
    end
  else
    begin
      exit(b);
    end;
end;


begin
  Write(min2_(min2_(2, 3), 4));
  Write(' ');
  Write(min2_(min2_(2, 4), 3));
  Write(' ');
  Write(min2_(min2_(3, 2), 4));
  Write(' ');
  Write(min2_(min2_(3, 4), 2));
  Write(' ');
  Write(min2_(min2_(4, 2), 3));
  Write(' ');
  Write(min2_(min2_(4, 3), 2));
  Write(''#10'');
end.


