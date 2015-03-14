program min4;
Uses math;


begin
  Write(Min(Min(Min(1, 2), 3), 4));
  Write(' ');
  Write(Min(Min(Min(1, 2), 4), 3));
  Write(' ');
  Write(Min(Min(Min(1, 3), 2), 4));
  Write(' ');
  Write(Min(Min(Min(1, 3), 4), 2));
  Write(' ');
  Write(Min(Min(Min(1, 4), 2), 3));
  Write(' ');
  Write(Min(Min(Min(1, 4), 3), 2));
  Write(''#10'');
  Write(Min(Min(Min(2, 1), 3), 4));
  Write(' ');
  Write(Min(Min(Min(2, 1), 4), 3));
  Write(' ');
  Write(Min(Min(Min(2, 3), 1), 4));
  Write(' ');
  Write(Min(Min(Min(2, 3), 4), 1));
  Write(' ');
  Write(Min(Min(Min(2, 4), 1), 3));
  Write(' ');
  Write(Min(Min(Min(2, 4), 3), 1));
  Write(''#10'');
  Write(Min(Min(Min(3, 1), 2), 4));
  Write(' ');
  Write(Min(Min(Min(3, 1), 4), 2));
  Write(' ');
  Write(Min(Min(Min(3, 2), 1), 4));
  Write(' ');
  Write(Min(Min(Min(3, 2), 4), 1));
  Write(' ');
  Write(Min(Min(Min(3, 4), 1), 2));
  Write(' ');
  Write(Min(Min(Min(3, 4), 2), 1));
  Write(''#10'');
  Write(Min(Min(Min(4, 1), 2), 3));
  Write(' ');
  Write(Min(Min(Min(4, 1), 3), 2));
  Write(' ');
  Write(Min(Min(Min(4, 2), 1), 3));
  Write(' ');
  Write(Min(Min(Min(4, 2), 3), 1));
  Write(' ');
  Write(Min(Min(Min(4, 3), 1), 2));
  Write(' ');
  Write(Min(Min(Min(4, 3), 2), 1));
  Write(''#10'');
end.


