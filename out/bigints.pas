program bigints;

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
function read_char_() : char;
var
   c : char;
begin
   c := read_char_aux();
   skip_char();
   read_char_ := c;
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


function max2(a : integer; b : integer) : integer;
begin
  if a > b
  then
    begin
      exit(a);
    end;
  exit(b);
end;

type
    bigint=^bigint_r;
    bigint_r = record
      bigint_sign : boolean;
      bigint_len : integer;
      bigint_chiffres : array of integer;
    end;

function read_bigint() : bigint;
var
  c : char;
  chiffres : array of integer;
  d : integer;
  i : integer;
  len : integer;
  out_ : bigint;
  sign : char;
  tmp : integer;
begin
  len := 0;
  len := read_int_();
  skip();
  sign := #95;
  sign := read_char_();
  skip();
  SetLength(chiffres, len);
  for d := 0 to  len - 1 do
  begin
    c := #95;
    c := read_char_();
    chiffres[d] := ord(c) - ord(#48);
  end;
  for i := 0 to  (len - 1) Div 2 do
  begin
    tmp := chiffres[i];
    chiffres[i] := chiffres[len - 1 - i];
    chiffres[len - 1 - i] := tmp;
  end;
  skip();
  new(out_);
  out_^.bigint_sign := sign
  =
  #43;
  out_^.bigint_len := len;
  out_^.bigint_chiffres := chiffres;
  exit(out_);
end;

procedure print_bigint(a : bigint);
var
  e : integer;
  i : integer;
begin
  if not a^.bigint_sign
  then
    begin
      Write(#45);
    end;
  for i := 0 to  a^.bigint_len - 1 do
  begin
    e := a^.bigint_chiffres[a^.bigint_len - 1 - i];
    Write(e);
  end;
end;

function bigint_eq(a : bigint; b : bigint) : boolean;
var
  i : integer;
begin
  { Renvoie vrai si a = b }
  if a^.bigint_sign <> b^.bigint_sign then
    begin
      exit(false);
    end
  else if a^.bigint_len <> b^.bigint_len
  then
    begin
      exit(false);
    end
  else
    begin
      for i := 0 to  a^.bigint_len - 1 do
      begin
        if a^.bigint_chiffres[i] <> b^.bigint_chiffres[i]
        then
          begin
            exit(false);
          end;
      end;
      exit(true);
    end;;
end;

function bigint_gt(a : bigint; b : bigint) : boolean;
var
  i : integer;
  j : integer;
begin
  { Renvoie vrai si a > b }
  if a^.bigint_sign and not b^.bigint_sign then
    begin
      exit(true);
    end
  else if not a^.bigint_sign and b^.bigint_sign
  then
    begin
      exit(false);
    end
  else
    begin
      if a^.bigint_len > b^.bigint_len then
        begin
          exit(a^.bigint_sign);
        end
      else if a^.bigint_len < b^.bigint_len
      then
        begin
          exit(not a^.bigint_sign);
        end
      else
        begin
          for i := 0 to  a^.bigint_len - 1 do
          begin
            j := a^.bigint_len - 1 - i;
            if a^.bigint_chiffres[j] > b^.bigint_chiffres[j] then
              begin
                exit(a^.bigint_sign);
              end
            else if a^.bigint_chiffres[j] < b^.bigint_chiffres[j]
            then
              begin
                exit(a^.bigint_sign);
              end;;
          end;
        end;;
      exit(true);
    end;;
end;

function bigint_lt(a : bigint; b : bigint) : boolean;
begin
  exit(not bigint_gt(a, b));
end;

function add_bigint_positif(a : bigint; b : bigint) : bigint;
var
  chiffres : array of integer;
  i : integer;
  len : integer;
  out_ : bigint;
  retenue : integer;
  tmp : integer;
begin
  { Une addition ou on en a rien a faire des signes }
  len := max2(a^.bigint_len, b^.bigint_len) + 1;
  retenue := 0;
  SetLength(chiffres, len);
  for i := 0 to  len - 1 do
  begin
    tmp := retenue;
    if i < a^.bigint_len
    then
      begin
        tmp := tmp + a^.bigint_chiffres[i];
      end;
    if i < b^.bigint_len
    then
      begin
        tmp := tmp + b^.bigint_chiffres[i];
      end;
    retenue := tmp Div 10;
    chiffres[i] := tmp Mod 10;
  end;
  if chiffres[len - 1] = 0
  then
    begin
      len := len - 1;
    end;
  new(out_);
  out_^.bigint_sign := true;
  out_^.bigint_len := len;
  out_^.bigint_chiffres := chiffres;
  exit(out_);
end;

function sub_bigint_positif(a : bigint; b : bigint) : bigint;
var
  chiffres : array of integer;
  i : integer;
  len : integer;
  out_ : bigint;
  retenue : integer;
  tmp : integer;
begin
  { Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
}
  len := a^.bigint_len;
  retenue := 0;
  SetLength(chiffres, len);
  for i := 0 to  len - 1 do
  begin
    tmp := retenue + a^.bigint_chiffres[i];
    if i < b^.bigint_len
    then
      begin
        tmp := tmp - b^.bigint_chiffres[i];
      end;
    if tmp < 0
    then
      begin
        tmp := tmp + 10;
        retenue := -1;
      end
    else
      begin
        retenue := 0;
      end;
    chiffres[i] := tmp;
  end;
  while (len > 0) and (chiffres[len - 1] = 0) do
  begin
    len := len - 1;
  end;
  new(out_);
  out_^.bigint_sign := true;
  out_^.bigint_len := len;
  out_^.bigint_chiffres := chiffres;
  exit(out_);
end;

function neg_bigint(a : bigint) : bigint;
var
  out_ : bigint;
begin
  new(out_);
  out_^.bigint_sign := not a^.bigint_sign;
  out_^.bigint_len := a^.bigint_len;
  out_^.bigint_chiffres := a^.bigint_chiffres;
  exit(out_);
end;

function add_bigint(a : bigint; b : bigint) : bigint;
begin
  if a^.bigint_sign = b^.bigint_sign then
    begin
      if a^.bigint_sign
      then
        begin
          exit(add_bigint_positif(a, b));
        end
      else
        begin
          exit(neg_bigint(add_bigint_positif(a, b)));
        end;
    end
  else if a^.bigint_sign
  then
    begin
      { a positif, b negatif }
      if bigint_gt(a, neg_bigint(b))
      then
        begin
          exit(sub_bigint_positif(a, b));
        end
      else
        begin
          exit(neg_bigint(sub_bigint_positif(b, a)));
        end;
    end
  else
    begin
      { a negatif, b positif }
      if bigint_gt(neg_bigint(a), b)
      then
        begin
          exit(neg_bigint(sub_bigint_positif(a, b)));
        end
      else
        begin
          exit(sub_bigint_positif(b, a));
        end;
    end;;
end;

function sub_bigint(a : bigint; b : bigint) : bigint;
begin
  exit(add_bigint(a, neg_bigint(b)));
end;

function mul_bigint_cp(a : bigint; b : bigint) : bigint;
var
  chiffres : array of integer;
  i : integer;
  j : integer;
  k : integer;
  l : integer;
  len : integer;
  out_ : bigint;
  retenue : integer;
begin
  { Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. }
  len := a^.bigint_len + b^.bigint_len + 1;
  SetLength(chiffres, len);
  for k := 0 to  len - 1 do
  begin
    chiffres[k] := 0;
  end;
  for i := 0 to  a^.bigint_len - 1 do
  begin
    retenue := 0;
    for j := 0 to  b^.bigint_len - 1 do
    begin
      chiffres[i + j] := chiffres[i + j] + retenue + b^.bigint_chiffres[j] * a^.bigint_chiffres[i];
      retenue := chiffres[i + j] Div 10;
      chiffres[i + j] := chiffres[i + j] Mod 10;
    end;
    chiffres[i + b^.bigint_len] := chiffres[i + b^.bigint_len] + retenue;
  end;
  chiffres[a^.bigint_len + b^.bigint_len] := chiffres[a^.bigint_len + b^.bigint_len - 1] Div 10;
  chiffres[a^.bigint_len + b^.bigint_len - 1] := chiffres[a^.bigint_len + b^.bigint_len - 1] Mod 10;
  for l := 0 to  2 do
  begin
    if chiffres[len - 1] = 0
    then
      begin
        len := len - 1;
      end;
  end;
  new(out_);
  out_^.bigint_sign := a^.bigint_sign
  =
  b^.bigint_sign;
  out_^.bigint_len := len;
  out_^.bigint_chiffres := chiffres;
  exit(out_);
end;

function bigint_premiers_chiffres(a : bigint; i : integer) : bigint;
var
  out_ : bigint;
begin
  new(out_);
  out_^.bigint_sign := a^.bigint_sign;
  out_^.bigint_len := i;
  out_^.bigint_chiffres := a^.bigint_chiffres;
  exit(out_);
end;

function bigint_shift(a : bigint; i : integer) : bigint;
var
  chiffres : array of integer;
  f : integer;
  k : integer;
  out_ : bigint;
begin
  f := a^.bigint_len + i;
  SetLength(chiffres, f);
  for k := 0 to  f - 1 do
  begin
    if k >= i
    then
      begin
        chiffres[k] := a^.bigint_chiffres[k - i];
      end
    else
      begin
        chiffres[k] := 0;
      end;
  end;
  new(out_);
  out_^.bigint_sign := a^.bigint_sign;
  out_^.bigint_len := a^.bigint_len
  +
  i;
  out_^.bigint_chiffres := chiffres;
  exit(out_);
end;

function mul_bigint(aa : bigint; bb : bigint) : bigint;
var
  a : bigint;
  ac : bigint;
  acdec : bigint;
  amoinsb : bigint;
  amoinsbcmoinsd : bigint;
  b : bigint;
  bd : bigint;
  c : bigint;
  cmoinsd : bigint;
  d : bigint;
  split : integer;
begin
  if (aa^.bigint_len < 3) or (bb^.bigint_len < 3)
  then
    begin
      exit(mul_bigint_cp(aa, bb));
    end;
  { Algorithme de Karatsuba }
  split := max2(aa^.bigint_len, bb^.bigint_len) Div 2;
  a := bigint_shift(aa, -split);
  b := bigint_premiers_chiffres(aa, split);
  c := bigint_shift(bb, -split);
  d := bigint_premiers_chiffres(bb, split);
  amoinsb := sub_bigint(a, b);
  cmoinsd := sub_bigint(c, d);
  ac := mul_bigint(a, c);
  bd := mul_bigint(b, d);
  amoinsbcmoinsd := mul_bigint(amoinsb, cmoinsd);
  acdec := bigint_shift(ac, 2 * split);
  exit(add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split)));
  { ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd }
end;

{
Division,
Modulo
Exp
}

var
  a : bigint;
  b : bigint;
  g : boolean;
begin
  a := read_bigint();
  b := read_bigint();
  print_bigint(a);
  Write('>>1=');
  print_bigint(bigint_shift(a, -1));
  Write(''#10'');
  print_bigint(a);
  Write('*');
  print_bigint(b);
  Write('=');
  print_bigint(mul_bigint(a, b));
  Write(''#10'');
  print_bigint(a);
  Write('*');
  print_bigint(b);
  Write('=');
  print_bigint(mul_bigint_cp(a, b));
  Write(''#10'');
  print_bigint(a);
  Write('+');
  print_bigint(b);
  Write('=');
  print_bigint(add_bigint(a, b));
  Write(''#10'');
  print_bigint(b);
  Write('-');
  print_bigint(a);
  Write('=');
  print_bigint(sub_bigint(b, a));
  Write(''#10'');
  print_bigint(a);
  Write('-');
  print_bigint(b);
  Write('=');
  print_bigint(sub_bigint(a, b));
  Write(''#10'');
  print_bigint(a);
  Write('>');
  print_bigint(b);
  Write('=');
  g := bigint_gt(a, b);
  if g
  then
    begin
      Write('True');
    end
  else
    begin
      Write('False');
    end;
  Write(''#10'');
end.


