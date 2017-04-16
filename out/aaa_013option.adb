
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_013option is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
type foo;
type foo_PTR is access foo;

type i is access Integer;
type j is Array (Integer range <>) of Integer;
type j_PTR is access j;

type k is access j_PTR;
type l is Array (Integer range <>) of i;
type l_PTR is access l;
type m is Array (Integer range <>) of foo_PTR;
type m_PTR is access m;
type n is Array (Integer range <>) of foo_PTR;
type n_PTR is access n;

type o is access n_PTR;
type foo is record
  a : Integer;
  b : i;
  c : k;
  d : l_PTR;
  e : j_PTR;
  f : foo_PTR;
  g : m_PTR;
  h : o;
end record;
function default0(a : in i; b : in foo_PTR; c : in l_PTR; d : in m_PTR; e : in k; f : in o) return Integer is
begin
  return 0;
end;
procedure aa(b : in foo_PTR) is
begin
  NULL;
  
end;

begin
  PString(new char_array'( To_C("___" & Character'Val(10))));
end;
