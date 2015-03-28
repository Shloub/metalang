
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure linkedList is


type stringptr is access all char_array;

type intlist;
type intlist_PTR is access intlist;
type intlist is record
  head : Integer;
  tail : intlist_PTR;
end record;

function cons(list : in intlist_PTR; i : in Integer) return intlist_PTR is
  out0 : intlist_PTR;
begin
  out0 := new intlist;
  out0.head := i;
  out0.tail := list;
  return out0;
end;

function rev2(empty : in intlist_PTR; acc : in intlist_PTR; torev : in intlist_PTR) return intlist_PTR is
  acc2 : intlist_PTR;
begin
  if torev = empty
  then
    return acc;
  else
    acc2 := new intlist;
    acc2.head := torev.head;
    acc2.tail := acc;
    return rev2(empty, acc, torev.tail);
  end if;
end;

function rev(empty : in intlist_PTR; torev : in intlist_PTR) return intlist_PTR is
begin
  return rev2(empty, empty, torev);
end;

procedure test(empty : in intlist_PTR) is
  list : intlist_PTR;
  i : Integer;
begin
  list := empty;
  i := (-1);
  while i /= 0 loop
    Get(i);
    if i /= 0
    then
      list := cons(list, i);
    end if;
  end loop;
end;


begin
  NULL;
  
end;
