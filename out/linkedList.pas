program linkedList;

var global_char : char;
var global_has_char : boolean;

procedure skip_char();
begin
   global_has_char := true;
   read(global_char);
end; 
function read_char_aux() : char;
begin
   if global_has_char then
      read_char_aux := global_char
   else
   begin
      skip_char();
      read_char_aux := global_char;
   end
end;
function read_int_() : integer;
var
   c    : char;
   i    : integer;
   sign :  integer;
begin
   i := 0;
   c := read_char_aux();
   if c = '-' then begin
      skip_char();
      sign := -1;
   end
   else
      sign := 1;

   repeat
      c := read_char_aux();
      if (ord(c) <=57) and (ord(c) >= 48) then
      begin
         i := i * 10 + ord(c) - 48;
         skip_char();
      end
      else
         exit(i * sign);
   until false;
end;

type
    intlist=^intlist_r;
    intlist_r = record
      head : integer;
      tail : intlist;
    end;

function cons_(list : intlist; i : integer) : intlist;
var
  out_ : intlist;
begin
  new(out_);
  out_^.head := i;
  out_^.tail := list;
  exit(out_);
end;

function rev2(empty : intlist; acc : intlist; torev : intlist) : intlist;
var
  acc2 : intlist;
begin
  if torev = empty
  then
    begin
      exit(acc);
    end
  else
    begin
      new(acc2);
      acc2^.head := torev^.head;
      acc2^.tail := acc;
      exit(rev2(empty, acc, torev^.tail));
    end;
end;

function rev(empty : intlist; torev : intlist) : intlist;
begin
  exit(rev2(empty, empty, torev));
end;

procedure test(empty : intlist);
var
  i : integer;
  list : intlist;
begin
  list := empty;
  i := -1;
  while i <> 0 do
  begin
    i := read_int_();
    if i <> 0
    then
      begin
        list := cons_(list, i);
      end;
  end;
end;


begin
  
end.


