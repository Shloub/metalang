
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure euler19 is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

function is_leap(year : in Integer) return Boolean is
begin
  return year rem 400 = 0 or else (year rem 100 /= 0 and then year rem 4 = 0);
end;

function ndayinmonth(month : in Integer; year : in Integer) return Integer is
begin
  if month = 0
  then
    return 31;
  else
    if month = 1
    then
      if is_leap(year)
      then
        return 29;
      else
        return 28;
      end if;
    else
      if month = 2
      then
        return 31;
      else
        if month = 3
        then
          return 30;
        else
          if month = 4
          then
            return 31;
          else
            if month = 5
            then
              return 30;
            else
              if month = 6
              then
                return 31;
              else
                if month = 7
                then
                  return 31;
                else
                  if month = 8
                  then
                    return 30;
                  else
                    if month = 9
                    then
                      return 31;
                    else
                      if month = 10
                      then
                        return 30;
                      else
                        if month = 11
                        then
                          return 31;
                        end if;
                      end if;
                    end if;
                  end if;
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
  end if;
  return 0;
end;

  year : Integer;
  ndays : Integer;
  month : Integer;
  dayofweek : Integer;
  count : Integer;
begin
  month := 0;
  year := 1901;
  dayofweek := 1;
  -- 01-01-1901 : mardi 
  
  count := 0;
  while year /= 2001 loop
    ndays := ndayinmonth(month, year);
    dayofweek := (dayofweek + ndays) rem 7;
    month := month + 1;
    if month = 12
    then
      month := 0;
      year := year + 1;
    end if;
    if dayofweek rem 7 = 6
    then
      count := count + 1;
    end if;
  end loop;
  PInt(count);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;
