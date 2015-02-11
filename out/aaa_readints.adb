
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_readints is
procedure SkipSpaces is
  C : Character;
  Eol : Boolean;
begin
  loop
    Look_Ahead(C, Eol);
    exit when Eol or C /= ' ';
    Get(C);
  end loop;
end;
type e is Array (Integer range <>) of Integer;
type e_PTR is access e;
type f is Array (Integer range <>) of e_PTR;
type f_PTR is access f;

  tab2 : f_PTR;
  tab1 : e_PTR;
  len : Integer;
  c : e_PTR;
begin
  Get(len);
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=len" & Character'Val(10) & "");
  tab1 := new e (0..len);
  for a in integer range (0)..len - (1) loop
    Get(tab1(a));
    SkipSpaces;
  end loop;
  for i in integer range (0)..len - (1) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
    String'Write (Text_Streams.Stream (Current_Output), "=>");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab1(i)), Left));
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
  Get(len);
  SkipSpaces;
  tab2 := new f (0..len - (1));
  for b in integer range (0)..len - (1) - (1) loop
    c := new e (0..len);
    for d in integer range (0)..len - (1) loop
      Get(c(d));
      SkipSpaces;
    end loop;
    tab2(b) := c;
  end loop;
  for i in integer range (0)..len - (2) loop
    for j in integer range (0)..len - (1) loop
      String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab2(i)(j)), Left));
      String'Write (Text_Streams.Stream (Current_Output), " ");
    end loop;
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
end;
