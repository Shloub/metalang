
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
type bb is Array (Integer range <>) of Integer;
type bb_PTR is access bb;
type bc is Array (Integer range <>) of bb_PTR;
type bc_PTR is access bc;

  w : Integer;
  tab2 : bc_PTR;
  tab1 : bb_PTR;
  len : Integer;
  f : Integer;
  ba : bb_PTR;
begin
  Get(f);
  SkipSpaces;
  len := f;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=len" & Character'Val(10) & "");
  tab1 := new bb (0..len);
  for k in integer range (0)..len - (1) loop
    Get(tab1(k));
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
  tab2 := new bc (0..len - (1));
  for s in integer range (0)..len - (1) - (1) loop
    ba := new bb (0..len);
    for v in integer range (0)..len - (1) loop
      Get(w);
      SkipSpaces;
      ba(v) := w;
    end loop;
    tab2(s) := ba;
  end loop;
  for i in integer range (0)..len - (2) loop
    for j in integer range (0)..len - (1) loop
      String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab2(i)(j)), Left));
      String'Write (Text_Streams.Stream (Current_Output), " ");
    end loop;
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
end;
