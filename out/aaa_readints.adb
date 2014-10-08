
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
  u : bb_PTR;
  tab2 : bc_PTR;
  tab1 : bb_PTR;
  r : bc_PTR;
  len : Integer;
  h : bb_PTR;
  f : Integer;
begin
  Get(f);
  SkipSpaces;
  len := f;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=len" & Character'Val(10) & "");
  h := new bb (0..len);
  for k in integer range (0)..len - (1) loop
    Get(h(k));
    SkipSpaces;
  end loop;
  tab1 := h;
  for i in integer range (0)..len - (1) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
    String'Write (Text_Streams.Stream (Current_Output), "=>");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab1(i)), Left));
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
  Get(len);
  SkipSpaces;
  r := new bc (0..len - (1));
  for s in integer range (0)..len - (1) - (1) loop
    u := new bb (0..len);
    for v in integer range (0)..len - (1) loop
      Get(w);
      SkipSpaces;
      u(v) := w;
    end loop;
    r(s) := u;
  end loop;
  tab2 := r;
  for i in integer range (0)..len - (2) loop
    for j in integer range (0)..len - (1) loop
      String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab2(i)(j)), Left));
      String'Write (Text_Streams.Stream (Current_Output), " ");
    end loop;
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  end loop;
end;
