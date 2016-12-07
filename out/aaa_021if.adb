
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure aaa_021if is


type stringptr is access all char_array;
procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;

procedure testA(a : in Boolean; b : in Boolean) is
begin
  if a
  then
    if b
    then
      PString(new char_array'( To_C("A")));
    else
      PString(new char_array'( To_C("B")));
    end if;
  else
    if b
    then
      PString(new char_array'( To_C("C")));
    else
      PString(new char_array'( To_C("D")));
    end if;
  end if;
end;

procedure testB(a : in Boolean; b : in Boolean) is
begin
  if a
  then
    PString(new char_array'( To_C("A")));
  else
    if b
    then
      PString(new char_array'( To_C("B")));
    else
      PString(new char_array'( To_C("C")));
    end if;
  end if;
end;

procedure testC(a : in Boolean; b : in Boolean) is
begin
  if a
  then
    if b
    then
      PString(new char_array'( To_C("A")));
    else
      PString(new char_array'( To_C("B")));
    end if;
  else
    PString(new char_array'( To_C("C")));
  end if;
end;

procedure testD(a : in Boolean; b : in Boolean) is
begin
  if a
  then
    if b
    then
      PString(new char_array'( To_C("A")));
    else
      PString(new char_array'( To_C("B")));
    end if;
    PString(new char_array'( To_C("C")));
  else
    PString(new char_array'( To_C("D")));
  end if;
end;

procedure testE(a : in Boolean; b : in Boolean) is
begin
  if a
  then
    if b
    then
      PString(new char_array'( To_C("A")));
    end if;
  else
    if b
    then
      PString(new char_array'( To_C("C")));
    else
      PString(new char_array'( To_C("D")));
    end if;
    PString(new char_array'( To_C("E")));
  end if;
end;

procedure test(a : in Boolean; b : in Boolean) is
begin
  testD(a, b);
  testE(a, b);
  PString(new char_array'( To_C("" & Character'Val(10))));
end;


begin
  test(TRUE, TRUE);
  test(TRUE, FALSE);
  test(FALSE, TRUE);
  test(FALSE, FALSE);
end;
