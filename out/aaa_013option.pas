program aaa_013option;

type foo=^foo_r;
  i = ^Longint;
  j = array of Longint;
  k = ^j;
  l = array of i;
  m = array of foo;
  n = array of foo;
  o = ^n;
  foo_r = record
    a : Longint;
    b : i;
    c : k;
    d : l;
    e : j;
    f : foo;
    g : m;
    h : o;
  end;

function default0(a : i; b : foo; c : l; d : m; e : k; f : o) : Longint;
begin
  exit(0);
end;

procedure aa(b : foo);
begin
  
end;


var
  a : i;
begin
  a := Nil;
  Write('___'#10'');
end.


