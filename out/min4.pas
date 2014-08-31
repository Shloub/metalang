program min4;

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
  Write(min2_(min2_(min2_(1, 2), 3), 4));
  Write(' ');
  Write(min2_(min2_(min2_(1, 2), 4), 3));
  Write(' ');
  Write(min2_(min2_(min2_(1, 3), 2), 4));
  Write(' ');
  Write(min2_(min2_(min2_(1, 3), 4), 2));
  Write(' ');
  Write(min2_(min2_(min2_(1, 4), 2), 3));
  Write(' ');
  Write(min2_(min2_(min2_(1, 4), 3), 2));
  Write(''#10'');
  Write(min2_(min2_(min2_(2, 1), 3), 4));
  Write(' ');
  Write(min2_(min2_(min2_(2, 1), 4), 3));
  Write(' ');
  Write(min2_(min2_(min2_(2, 3), 1), 4));
  Write(' ');
  Write(min2_(min2_(min2_(2, 3), 4), 1));
  Write(' ');
  Write(min2_(min2_(min2_(2, 4), 1), 3));
  Write(' ');
  Write(min2_(min2_(min2_(2, 4), 3), 1));
  Write(''#10'');
  Write(min2_(min2_(min2_(3, 1), 2), 4));
  Write(' ');
  Write(min2_(min2_(min2_(3, 1), 4), 2));
  Write(' ');
  Write(min2_(min2_(min2_(3, 2), 1), 4));
  Write(' ');
  Write(min2_(min2_(min2_(3, 2), 4), 1));
  Write(' ');
  Write(min2_(min2_(min2_(3, 4), 1), 2));
  Write(' ');
  Write(min2_(min2_(min2_(3, 4), 2), 1));
  Write(''#10'');
  Write(min2_(min2_(min2_(4, 1), 2), 3));
  Write(' ');
  Write(min2_(min2_(min2_(4, 1), 3), 2));
  Write(' ');
  Write(min2_(min2_(min2_(4, 2), 1), 3));
  Write(' ');
  Write(min2_(min2_(min2_(4, 2), 3), 1));
  Write(' ');
  Write(min2_(min2_(min2_(4, 3), 1), 2));
  Write(' ');
  Write(min2_(min2_(min2_(4, 3), 2), 1));
  Write(''#10'');
end.


