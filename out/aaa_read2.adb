
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

type e is Array (Integer range <>) of Integer;
type e_PTR is access e;
type f is Array (Integer range <>) of Character;
type f_PTR is access f;

  tmpc : Character;
  tab4 : f_PTR;
  tab2 : e_PTR;
  tab : e_PTR;
  strlen : Integer;
  len : Integer;
  c : Integer;
begin
  Get(len);
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(len), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=len" & Character'Val(10) & "");
  tab := new e (0..len);
  for a in integer range (0)..len - (1) loop
    Get(tab(a));
    SkipSpaces;
  end loop;
  for i in integer range (0)..len - (1) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
    String'Write (Text_Streams.Stream (Current_Output), "=>");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab(i)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  tab2 := new e (0..len);
  for b in integer range (0)..len - (1) loop
    Get(tab2(b));
    SkipSpaces;
  end loop;
  for i_0 in integer range (0)..len - (1) loop
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i_0), Left));
    String'Write (Text_Streams.Stream (Current_Output), "==>");
    String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(tab2(i_0)), Left));
    String'Write (Text_Streams.Stream (Current_Output), " ");
  end loop;
  Get(strlen);
  SkipSpaces;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(strlen), Left));
  String'Write (Text_Streams.Stream (Current_Output), "=strlen" & Character'Val(10) & "");
  tab4 := new f (0..strlen);
  for d in integer range (0)..strlen - (1) loop
    Get(tab4(d));
  end loop;
  SkipSpaces;
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
