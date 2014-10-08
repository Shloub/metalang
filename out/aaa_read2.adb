
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_read2 is
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
--
--Ce test permet de vérifier si les différents backends pour les langages implémentent bien
--read int, read char et skip
--

type v is Array (Integer range <>) of Integer;
type v_PTR is access v;
type w is Array (Integer range <>) of Character;
type w_PTR is access w;

  tmpc : Character;
  tab4 : w_PTR;
  tab2 : v_PTR;
  tab : v_PTR;
  strlen : Integer;
  r : w_PTR;
  p : Integer;
  len : Integer;
  k : v_PTR;
  e : v_PTR;
  c : Integer;
  b : Integer;
begin
  Get(b);
  SkipSpaces;
  len := b;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=len" & Character'Val(10) & "");
  e := new v (0..len);
  for f in integer range (0)..len - (1) loop
    Get(e(f));
    SkipSpaces;
  end loop;
  tab := e;
  for i in integer range (0)..len - (1) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
    String'Write (Text_Streams.Stream (Current_Output), "=>");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab(i)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  k := new v (0..len);
  for l in integer range (0)..len - (1) loop
    Get(k(l));
    SkipSpaces;
  end loop;
  tab2 := k;
  for i_0 in integer range (0)..len - (1) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i_0), Left));
    String'Write (Text_Streams.Stream (Current_Output), "==>");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab2(i_0)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
  end loop;
  Get(p);
  SkipSpaces;
  strlen := p;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(strlen), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=strlen" & Character'Val(10) & "");
  r := new w (0..strlen);
  for s in integer range (0)..strlen - (1) loop
    Get(r(s));
  end loop;
  SkipSpaces;
  tab4 := r;
  for i3 in integer range (0)..strlen - (1) loop
    tmpc := tab4(i3);
    c := Character'Pos(tmpc);
    Character'Write (Text_Streams.Stream (Current_Output), tmpc);
    String'Write (Text_Streams.Stream (Current_Output), ":");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(c), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    if tmpc /= ' '
    then
      c := ((c - Character'Pos('a')) + (13)) rem (26) + Character'Pos('a');
    end if;
    tab4(i3) := Character'Val(c);
  end loop;
  for j in integer range (0)..strlen - (1) loop
    Character'Write (Text_Streams.Stream (Current_Output), tab4(j));
  end loop;
end;
