require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def is_leap( year )
    return ((mod(year, 400)) == 0 || ((mod(year, 100)) != 0 && (mod(year, 4)) == 0));
end

def ndayinmonth( month, year )
    if month == 0 then
      return (31);
    elsif month == 1 then
      if is_leap(year) then
        return (29);
      else
        return (28);
      end
    elsif month == 2 then
      return (31);
    elsif month == 3 then
      return (30);
    elsif month == 4 then
      return (31);
    elsif month == 5 then
      return (30);
    elsif month == 6 then
      return (31);
    elsif month == 7 then
      return (31);
    elsif month == 8 then
      return (30);
    elsif month == 9 then
      return (31);
    elsif month == 10 then
      return (30);
    elsif month == 11 then
      return (31);
    end
    return (0);
end

month = 0
year = 1901
dayofweek = 1

=begin
 01-01-1901 : mardi 
=end

count = 0
while year != 2001 do
  ndays = ndayinmonth(month, year)
  dayofweek = mod(dayofweek + ndays, 7)
  month += 1
  if month == 12 then
    month = 0
    year += 1
  end
  if (mod(dayofweek, 7)) == 6 then
    count += 1
  end
end
printf "%d\n", count

