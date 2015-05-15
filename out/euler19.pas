program euler19;

function is_leap(year : Longint) : boolean;
begin
  exit((year Mod 400 = 0) or (year Mod 100 <> 0) and (year Mod 4 = 0));
end;

function ndayinmonth(month : Longint; year : Longint) : Longint;
begin
  if month = 0 then
    begin
      exit(31);
    end
  else if month = 1 then
    begin
      if is_leap(year)
      then
        begin
          exit(29);
        end
      else
        begin
          exit(28);
        end;
    end
  else if month = 2 then
    begin
      exit(31);
    end
  else if month = 3 then
    begin
      exit(30);
    end
  else if month = 4 then
    begin
      exit(31);
    end
  else if month = 5 then
    begin
      exit(30);
    end
  else if month = 6 then
    begin
      exit(31);
    end
  else if month = 7 then
    begin
      exit(31);
    end
  else if month = 8 then
    begin
      exit(30);
    end
  else if month = 9 then
    begin
      exit(31);
    end
  else if month = 10 then
    begin
      exit(30);
    end
  else if month = 11
  then
    begin
      exit(31);
    end;;;;;;;;;;;;
  exit(0);
end;


var
  count : Longint;
  dayofweek : Longint;
  month : Longint;
  ndays : Longint;
  year : Longint;
begin
  month := 0;
  year := 1901;
  dayofweek := 1;
  { 01-01-1901 : mardi }
  count := 0;
  while year <> 2001 do
  begin
    ndays := ndayinmonth(month, year);
    dayofweek := (dayofweek + ndays) Mod 7;
    month := month + 1;
    if month = 12
    then
      begin
        month := 0;
        year := year + 1;
      end;
    if dayofweek Mod 7 = 6
    then
      begin
        count := count + 1;
      end;
  end;
  Write(count);
  Write(''#10'');
end.


