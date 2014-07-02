program sort;

var global_char : char;
var global_has_char : boolean;

procedure skip_char();
begin
   global_has_char := true;
   read(global_char);
end; 
procedure skip();
var
   n : char;
   t : char;
   s : char;
begin
   n := #13;
   t := #10;
   s := #32;
   if not( global_has_char ) then
      skip_char();
   while (global_char = s) or (global_char = n) or (global_char = t) do
   begin
      skip_char();
   end;
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
function read_int_() : Longint;
var
   c    : char;
   i    : Longint;
   sign :  Longint;
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

type c = array of Longint;
function copytab(tab : c; len : Longint) : c;
var
  i : Longint;
  o : c;
begin
  SetLength(o, len);
  for i := 0 to  len - 1 do
  begin
    o[i] := tab[i];
  end;
  exit(o);
end;

procedure bubblesort(tab : c; len : Longint);
var
  i : Longint;
  j : Longint;
  tmp : Longint;
begin
  for i := 0 to  len - 1 do
  begin
    for j := i + 1 to  len - 1 do
    begin
      if tab[i] > tab[j]
      then
        begin
          tmp := tab[i];
          tab[i] := tab[j];
          tab[j] := tmp;
        end;
    end;
  end;
end;

procedure qsort_(tab : c; len : Longint; i : Longint; j : Longint);
var
  i0 : Longint;
  j0 : Longint;
  tmp : Longint;
begin
  if i < j
  then
    begin
      i0 := i;
      j0 := j;
      { pivot : tab[0] }
      while i <> j do
      begin
        if tab[i] > tab[j]
        then
          begin
            if i = (j - 1)
            then
              begin
                { on inverse simplement}
                tmp := tab[i];
                tab[i] := tab[j];
                tab[j] := tmp;
                i := i + 1;
              end
            else
              begin
                { on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] }
                tmp := tab[i];
                tab[i] := tab[j];
                tab[j] := tab[i + 1];
                tab[i + 1] := tmp;
                i := i + 1;
              end;
          end
        else
          begin
            j := j - 1;
          end;
      end;
      qsort_(tab, len, i0, i - 1);
      qsort_(tab, len, i + 1, j0);
    end;
end;


var
  a : Longint;
  b : Longint;
  i : Longint;
  i_ : Longint;
  len : Longint;
  tab : c;
  tab2 : c;
  tab3 : c;
  tmp : Longint;
begin
  len := 2;
  len := read_int_();
  skip();
  SetLength(tab, len);
  for i_ := 0 to  len - 1 do
  begin
    tmp := 0;
    tmp := read_int_();
    skip();
    tab[i_] := tmp;
  end;
  tab2 := copytab(tab, len);
  bubblesort(tab2, len);
  for i := 0 to  len - 1 do
  begin
    a := tab2[i];
    Write(a);
    Write(' ');
  end;
  Write(''#10'');
  tab3 := copytab(tab, len);
  qsort_(tab3, len, 0, len - 1);
  for i := 0 to  len - 1 do
  begin
    b := tab3[i];
    Write(b);
    Write(' ');
  end;
  Write(''#10'');
end.


