
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler50 is
function min2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a < b
  then
    return a;
  else
    return b;
  end if;
end;

type d is Array (Integer range <>) of Integer;
type d_PTR is access d;
function eratostene(t : in d_PTR; max0 : in Integer) return Integer is
  n : Integer;
  j : Integer;
begin
  n := (0);
  for i in integer range (2)..max0 - (1) loop
    if t(i) = i
    then
      n := n + (1);
      if max0 / i > i
      then
        j := i * i;
        while j < max0 and then j > (0) loop
          t(j) := (0);
          j := j + i;
        end loop;
      end if;
    end if;
  end loop;
  return n;
end;


  sum : d_PTR;
  stop : Integer;
  resp : Integer;
  process : Boolean;
  primes : d_PTR;
  nprimes : Integer;
  maxl : Integer;
  maximumprimes : Integer;
  len : Integer;
  l : Integer;
  era : d_PTR;
begin
  maximumprimes := (1000001);
  era := new d (0..maximumprimes);
  for j in integer range (0)..maximumprimes - (1) loop
    era(j) := j;
  end loop;
  nprimes := eratostene(era, maximumprimes);
  primes := new d (0..nprimes);
  for o in integer range (0)..nprimes - (1) loop
    primes(o) := (0);
  end loop;
  l := (0);
  for k in integer range (2)..maximumprimes - (1) loop
    if era(k) = k
    then
      primes(l) := k;
      l := l + (1);
    end if;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(l), Left));
  String'Write (Text_Streams.Stream (Current_Output), " == ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(nprimes), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  sum := new d (0..nprimes);
  for i_0 in integer range (0)..nprimes - (1) loop
    sum(i_0) := primes(i_0);
  end loop;
  maxl := (0);
  process := TRUE;
  stop := maximumprimes - (1);
  len := (1);
  resp := (1);
  while process loop
    process := FALSE;
    for i in integer range (0)..stop loop
      if i + len < nprimes
      then
        sum(i) := sum(i) + primes(i + len);
        if maximumprimes > sum(i)
        then
          process := TRUE;
          if era(sum(i)) = sum(i)
          then
            maxl := len;
            resp := sum(i);
          end if;
        else
          stop := min2_0(stop, i);
        end if;
      end if;
    end loop;
    len := len + (1);
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(resp), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(maxl), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
