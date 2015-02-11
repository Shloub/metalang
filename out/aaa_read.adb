
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_read is
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

type a is Array (Integer range <>) of Integer;
type a_PTR is access a;
type b is Array (Integer range <>) of Character;
type b_PTR is access b;

  tmpi2 : Integer;
  tmpi1 : Integer;
  tmpc : Character;
  tab4 : b_PTR;
  tab2 : a_PTR;
  tab : a_PTR;
  strlen : Integer;
  len : Integer;
  c : Integer;
begin
  Get(len);
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=len" & Character'Val(10));
  len := len * (2);
  String'Write (Text_Streams.Stream (Current_Output), "len*2=");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  len := len / (2);
  tab := new a (0..len);
  for i in integer range (0)..len - (1) loop
    Get(tmpi1);
    SkipSpaces;
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
    String'Write (Text_Streams.Stream (Current_Output), "=>");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tmpi1), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    tab(i) := tmpi1;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10));
  tab2 := new a (0..len);
  for i_0 in integer range (0)..len - (1) loop
    Get(tmpi2);
    SkipSpaces;
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i_0), Left));
    String'Write (Text_Streams.Stream (Current_Output), "==>");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tmpi2), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    tab2(i_0) := tmpi2;
  end loop;
  Get(strlen);
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(strlen), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=strlen" & Character'Val(10));
  tab4 := new b (0..strlen);
  for toto in integer range (0)..strlen - (1) loop
    Get(tmpc);
    c := Character'Pos(tmpc);
    Character'Write (Text_Streams.Stream (Current_Output), tmpc);
    String'Write (Text_Streams.Stream (Current_Output), ":");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(c), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
    if tmpc /= ' '
    then
      c := ((c - Character'Pos('a')) + (13)) rem (26) + Character'Pos('a');
    end if;
    tab4(toto) := Character'Val(c);
  end loop;
  for j in integer range (0)..strlen - (1) loop
    Character'Write (Text_Streams.Stream (Current_Output), tab4(j));
  end loop;
end;
