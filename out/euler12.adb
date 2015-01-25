
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler12 is
function max2_0(a : in Integer; b : in Integer) return Integer is
begin
  if a > b
  then
    return a;
  else
    return b;
  end if;
end;

type h is Array (Integer range <>) of Integer;
type h_PTR is access h;
function eratostene(t : in h_PTR; max0 : in Integer) return Integer is
  n : Integer;
  j : Integer;
begin
  n := (0);
  for i in integer range (2)..max0 - (1) loop
    if t(i) = i
    then
      j := i * i;
      n := n + (1);
      while j < max0 and then j > (0) loop
        t(j) := (0);
        j := j + i;
      end loop;
    end if;
  end loop;
  return n;
end;

function fillPrimesFactors(t : in h_PTR; p : in Integer; primes : in h_PTR;
nprimes : in Integer) return Integer is
  n : Integer;
  d : Integer;
begin
  n := p;
  for i in integer range (0)..nprimes - (1) loop
    d := primes(i);
    while (n rem d) = (0) loop
      t(d) := t(d) + (1);
      n := n / d;
    end loop;
    if n = (1)
    then
      return primes(i);
    end if;
  end loop;
  return n;
end;

function find(ndiv2 : in Integer) return Integer is
  primesFactors : h_PTR;
  primes : h_PTR;
  nprimes : Integer;
  ndivs : Integer;
  maximumprimes : Integer;
  max0 : Integer;
  l : Integer;
  era : h_PTR;
begin
  maximumprimes := (110);
  era := new h (0..maximumprimes);
  for j in integer range (0)..maximumprimes - (1) loop
    era(j) := j;
  end loop;
  nprimes := eratostene(era, maximumprimes);
  primes := new h (0..nprimes);
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
  for n in integer range (1)..(10000) loop
    primesFactors := new h (0..n + (2));
    for m in integer range (0)..n + (2) - (1) loop
      primesFactors(m) := (0);
    end loop;
    max0 := max2_0(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + (1), primes, nprimes));
    primesFactors((2)) := primesFactors((2)) - (1);
    ndivs := (1);
    for i in integer range (0)..max0 loop
      if primesFactors(i) /= (0)
      then
        ndivs := ndivs * ((1) + primesFactors(i));
      end if;
    end loop;
    if ndivs > ndiv2
    then
      return (n * (n + (1))) / (2);
    end if;
    -- print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" 
    
  end loop;
  return (0);
end;


begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(find((500))), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;