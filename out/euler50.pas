program euler50;

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

type d = array of Longint;
function eratostene(t : d; max0 : Longint) : Longint;
var
  i : Longint;
  j : Longint;
  n : Longint;
begin
  n := 0;
  for i := 2 to  max0 - 1 do
  begin
    if t[i] = i
    then
      begin
        n := n + 1;
        if (max0 Div i) > i
        then
          begin
            j := i * i;
            while (j < max0) and (j > 0) do
            begin
              t[j] := 0;
              j := j + i;
            end;
          end;
      end;
  end;
  exit(n);
end;


var
  era : d;
  i : Longint;
  i_ : Longint;
  j : Longint;
  k : Longint;
  l : Longint;
  len : Longint;
  maximumprimes : Longint;
  maxl : Longint;
  nprimes : Longint;
  o : Longint;
  primes : d;
  process : boolean;
  resp : Longint;
  stop : Longint;
  sum : d;
begin
  maximumprimes := 1000001;
  SetLength(era, maximumprimes);
  for j := 0 to  maximumprimes - 1 do
  begin
    era[j] := j;
  end;
  nprimes := eratostene(era, maximumprimes);
  SetLength(primes, nprimes);
  for o := 0 to  nprimes - 1 do
  begin
    primes[o] := 0;
  end;
  l := 0;
  for k := 2 to  maximumprimes - 1 do
  begin
    if era[k] = k
    then
      begin
        primes[l] := k;
        l := l + 1;
      end;
  end;
  Write(l);
  Write(' == ');
  Write(nprimes);
  Write(''#10'');
  SetLength(sum, nprimes);
  for i_ := 0 to  nprimes - 1 do
  begin
    sum[i_] := primes[i_];
  end;
  maxl := 0;
  process := true;
  stop := maximumprimes - 1;
  len := 1;
  resp := 1;
  while process do
  begin
    process := false;
    for i := 0 to  stop do
    begin
      if (i + len) < nprimes
      then
        begin
          sum[i] := sum[i] + primes[i + len];
          if maximumprimes > sum[i]
          then
            begin
              process := true;
              if era[sum[i]] = sum[i]
              then
                begin
                  maxl := len;
                  resp := sum[i];
                end;
            end
          else
            begin
              stop := min2_(stop, i);
            end;
        end;
    end;
    len := len + 1;
  end;
  Write(resp);
  Write(''#10'');
  Write(maxl);
  Write(''#10'');
end.


