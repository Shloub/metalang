require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def read_bigint( len )
    chiffres = [];
    for j in (0 ..  len - 1) do
      c=scanf("%c")[0];
      chiffres[j] = c.ord;
    end
    for i in (0 ..  ((len - 1).to_f / 2).to_i) do
      tmp = chiffres[i]
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    end
    return ({
      "bigint_sign" => true,
      "bigint_len" => len,
      "bigint_chiffres" => chiffres});
end

def print_bigint( a )
    if not(a["bigint_sign"]) then
      printf "%c", "-"
    end
    for i in (0 ..  a["bigint_len"] - 1) do
      printf "%d", a["bigint_chiffres"][a["bigint_len"] - 1 - i]
    end
end

def bigint_eq( a, b )
    
=begin
 Renvoie vrai si a = b 
=end

    if a["bigint_sign"] != b["bigint_sign"] then
      return (false);
    elsif a["bigint_len"] != b["bigint_len"] then
      return (false);
    else
      for i in (0 ..  a["bigint_len"] - 1) do
        if a["bigint_chiffres"][i] != b["bigint_chiffres"][i] then
          return (false);
        end
      end
      return (true);
    end
end

def bigint_gt( a, b )
    
=begin
 Renvoie vrai si a > b 
=end

    if a["bigint_sign"] && not(b["bigint_sign"]) then
      return (true);
    elsif not(a["bigint_sign"]) && b["bigint_sign"] then
      return (false);
    else
      if a["bigint_len"] > b["bigint_len"] then
        return (a["bigint_sign"]);
      elsif a["bigint_len"] < b["bigint_len"] then
        return (not(a["bigint_sign"]));
      else
        for i in (0 ..  a["bigint_len"] - 1) do
          j = a["bigint_len"] - 1 - i
          if a["bigint_chiffres"][j] > b["bigint_chiffres"][j] then
            return (a["bigint_sign"]);
          elsif a["bigint_chiffres"][j] < b["bigint_chiffres"][j] then
            return (not(a["bigint_sign"]));
          end
        end
      end
      return (true);
    end
end

def bigint_lt( a, b )
    return (not(bigint_gt(a, b)));
end

def add_bigint_positif( a, b )
    
=begin
 Une addition ou on en a rien a faire des signes 
=end

    len = [a["bigint_len"], b["bigint_len"]].max + 1
    retenue = 0
    chiffres = [];
    for i in (0 ..  len - 1) do
      tmp = retenue
      if i < a["bigint_len"] then
        tmp += a["bigint_chiffres"][i]
      end
      if i < b["bigint_len"] then
        tmp += b["bigint_chiffres"][i]
      end
      retenue = (tmp.to_f / 10).to_i;
      chiffres[i] = mod(tmp, 10);
    end
    while len > 0 && chiffres[len - 1] == 0 do
      len -= 1
    end
    return ({
      "bigint_sign" => true,
      "bigint_len" => len,
      "bigint_chiffres" => chiffres});
end

def sub_bigint_positif( a, b )
    
=begin
 Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b

=end

    len = a["bigint_len"]
    retenue = 0
    chiffres = [];
    for i in (0 ..  len - 1) do
      tmp = retenue + a["bigint_chiffres"][i]
      if i < b["bigint_len"] then
        tmp -= b["bigint_chiffres"][i]
      end
      if tmp < 0 then
        tmp += 10
        retenue = -1;
      else
        retenue = 0;
      end
      chiffres[i] = tmp;
    end
    while len > 0 && chiffres[len - 1] == 0 do
      len -= 1
    end
    return ({
      "bigint_sign" => true,
      "bigint_len" => len,
      "bigint_chiffres" => chiffres});
end

def neg_bigint( a )
    return ({
      "bigint_sign" => not(a["bigint_sign"]),
      "bigint_len" => a["bigint_len"],
      "bigint_chiffres" => a["bigint_chiffres"]});
end

def add_bigint( a, b )
    if a["bigint_sign"] == b["bigint_sign"] then
      if a["bigint_sign"] then
        return (add_bigint_positif(a, b));
      else
        return (neg_bigint(add_bigint_positif(a, b)));
      end
    elsif a["bigint_sign"] then
      
=begin
 a positif, b negatif 
=end

      if bigint_gt(a, neg_bigint(b)) then
        return (sub_bigint_positif(a, b));
      else
        return (neg_bigint(sub_bigint_positif(b, a)));
      end
    else
      
=begin
 a negatif, b positif 
=end

      if bigint_gt(neg_bigint(a), b) then
        return (neg_bigint(sub_bigint_positif(a, b)));
      else
        return (sub_bigint_positif(b, a));
      end
    end
end

def sub_bigint( a, b )
    return (add_bigint(a, neg_bigint(b)));
end

def mul_bigint_cp( a, b )
    
=begin
 Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. 
=end

    len = a["bigint_len"] + b["bigint_len"] + 1
    chiffres = [];
    for k in (0 ..  len - 1) do
      chiffres[k] = 0;
    end
    for i in (0 ..  a["bigint_len"] - 1) do
      retenue = 0
      for j in (0 ..  b["bigint_len"] - 1) do
        chiffres[i + j] = chiffres[i + j] + retenue + b["bigint_chiffres"][j] * a["bigint_chiffres"][i];
        retenue = (chiffres[i + j].to_f / 10).to_i;
        chiffres[i + j] = mod(chiffres[i + j], 10);
      end
      chiffres[i + b["bigint_len"]] = chiffres[i + b["bigint_len"]] + retenue;
    end
    chiffres[a["bigint_len"] + b["bigint_len"]] = (chiffres[a["bigint_len"] + b["bigint_len"] - 1].to_f / 10).to_i;
    chiffres[a["bigint_len"] + b["bigint_len"] - 1] = mod(chiffres[a["bigint_len"] + b["bigint_len"] - 1], 10);
    for l in (0 ..  2) do
      if len != 0 && chiffres[len - 1] == 0 then
        len -= 1
      end
    end
    return ({
      "bigint_sign" => a["bigint_sign"] == b["bigint_sign"],
      "bigint_len" => len,
      "bigint_chiffres" => chiffres});
end

def bigint_premiers_chiffres( a, i )
    len = [i, a["bigint_len"]].min
    while len != 0 && a["bigint_chiffres"][len - 1] == 0 do
      len -= 1
    end
    return ({
      "bigint_sign" => a["bigint_sign"],
      "bigint_len" => len,
      "bigint_chiffres" => a["bigint_chiffres"]});
end

def bigint_shift( a, i )
    chiffres = [];
    for k in (0 ..  a["bigint_len"] + i - 1) do
      if k >= i then
        chiffres[k] = a["bigint_chiffres"][k - i];
      else
        chiffres[k] = 0;
      end
    end
    return ({
      "bigint_sign" => a["bigint_sign"],
      "bigint_len" => a["bigint_len"] + i,
      "bigint_chiffres" => chiffres});
end

def mul_bigint( aa, bb )
    if aa["bigint_len"] == 0 then
      return (aa);
    elsif bb["bigint_len"] == 0 then
      return (bb);
    elsif aa["bigint_len"] < 3 || bb["bigint_len"] < 3 then
      return (mul_bigint_cp(aa, bb));
    end
    
=begin
 Algorithme de Karatsuba 
=end

    split = ([aa["bigint_len"], bb["bigint_len"]].min.to_f / 2).to_i
    a = bigint_shift(aa, -split)
    b = bigint_premiers_chiffres(aa, split)
    c = bigint_shift(bb, -split)
    d = bigint_premiers_chiffres(bb, split)
    amoinsb = sub_bigint(a, b)
    cmoinsd = sub_bigint(c, d)
    ac = mul_bigint(a, c)
    bd = mul_bigint(b, d)
    amoinsbcmoinsd = mul_bigint(amoinsb, cmoinsd)
    acdec = bigint_shift(ac, 2 * split)
    return (add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split)));
    
=begin
 ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd 
=end

end


=begin

Division,
Modulo

=end

def log10( a )
    out_ = 1
    while a >= 10 do
      a = (a.to_f / 10).to_i
      out_ += 1
    end
    return (out_);
end

def bigint_of_int( i )
    size = log10(i)
    if i == 0 then
      size = 0;
    end
    t = [];
    for j in (0 ..  size - 1) do
      t[j] = 0;
    end
    for k in (0 ..  size - 1) do
      t[k] = mod(i, 10);
      i = (i.to_f / 10).to_i
    end
    return ({
      "bigint_sign" => true,
      "bigint_len" => size,
      "bigint_chiffres" => t});
end

def fact_bigint( a )
    one = bigint_of_int(1)
    out_ = one
    while not(bigint_eq(a, one)) do
      out_ = mul_bigint(a, out_);
      a = sub_bigint(a, one);
    end
    return (out_);
end

def sum_chiffres_bigint( a )
    out_ = 0
    for i in (0 ..  a["bigint_len"] - 1) do
      out_ += a["bigint_chiffres"][i]
    end
    return (out_);
end


=begin
 http://projecteuler.net/problem=20 
=end

def euler20(  )
    a = bigint_of_int(15)
    
=begin
 normalement c'est 100 
=end

    a = fact_bigint(a);
    return (sum_chiffres_bigint(a));
end

def bigint_exp( a, b )
    if b == 1 then
      return (a);
    elsif (mod(b, 2)) == 0 then
      return (bigint_exp(mul_bigint(a, a), (b.to_f / 2).to_i));
    else
      return (mul_bigint(a, bigint_exp(a, b - 1)));
    end
end

def bigint_exp_10chiffres( a, b )
    a = bigint_premiers_chiffres(a, 10);
    if b == 1 then
      return (a);
    elsif (mod(b, 2)) == 0 then
      return (bigint_exp_10chiffres(mul_bigint(a, a), (b.to_f / 2).to_i));
    else
      return (mul_bigint(a, bigint_exp_10chiffres(a, b - 1)));
    end
end

def euler48(  )
    sum = bigint_of_int(0)
    for i in (1 ..  100) do
      
=begin
 1000 normalement 
=end

      ib = bigint_of_int(i)
      ibeib = bigint_exp_10chiffres(ib, i)
      sum = add_bigint(sum, ibeib);
      sum = bigint_premiers_chiffres(sum, 10);
    end
    print "euler 48 = ";
    print_bigint(sum);
    print "\n";
end

def euler16(  )
    a = bigint_of_int(2)
    a = bigint_exp(a, 100);
    
=begin
 1000 normalement 
=end

    return (sum_chiffres_bigint(a));
end

def euler25(  )
    i = 2
    a = bigint_of_int(1)
    b = bigint_of_int(1)
    while b["bigint_len"] < 100 do
      
=begin
 1000 normalement 
=end

      c = add_bigint(a, b)
      a = b;
      b = c;
      i += 1
    end
    return (i);
end

def euler29(  )
    maxA = 5
    maxB = 5
    a_bigint = [];
    for j in (0 ..  maxA + 1 - 1) do
      a_bigint[j] = bigint_of_int(j * j);
    end
    a0_bigint = [];
    for j2 in (0 ..  maxA + 1 - 1) do
      a0_bigint[j2] = bigint_of_int(j2);
    end
    b = [];
    for k in (0 ..  maxA + 1 - 1) do
      b[k] = 2;
    end
    n = 0
    found = true
    while found do
      min_ = a0_bigint[0]
      found = false;
      for i in (2 ..  maxA) do
        if b[i] <= maxB then
          if found then
            if bigint_lt(a_bigint[i], min_) then
              min_ = a_bigint[i];
            end
          else
            min_ = a_bigint[i];
            found = true;
          end
        end
      end
      if found then
        n += 1
        for l in (2 ..  maxA) do
          if bigint_eq(a_bigint[l], min_) && b[l] <= maxB then
            b[l] = b[l] + 1;
            a_bigint[l] = mul_bigint(a_bigint[l], a0_bigint[l]);
          end
        end
      end
    end
    return (n);
end

printf "%d\n", euler29()
sum = read_bigint(50)
for i in (2 ..  100) do
  scanf("%*\n");
  tmp = read_bigint(50)
  sum = add_bigint(sum, tmp);
end
print "euler13 = ";
print_bigint(sum);
printf "\neuler25 = %d\neuler16 = %d\n", euler25(), euler16()
euler48();
printf "euler20 = %d\n", euler20()
a = bigint_of_int(999999)
b = bigint_of_int(9951263)
print_bigint(a);
print ">>1=";
print_bigint(bigint_shift(a, -1));
print "\n";
print_bigint(a);
print "*";
print_bigint(b);
print "=";
print_bigint(mul_bigint(a, b));
print "\n";
print_bigint(a);
print "*";
print_bigint(b);
print "=";
print_bigint(mul_bigint_cp(a, b));
print "\n";
print_bigint(a);
print "+";
print_bigint(b);
print "=";
print_bigint(add_bigint(a, b));
print "\n";
print_bigint(b);
print "-";
print_bigint(a);
print "=";
print_bigint(sub_bigint(b, a));
print "\n";
print_bigint(a);
print "-";
print_bigint(b);
print "=";
print_bigint(sub_bigint(a, b));
print "\n";
print_bigint(a);
print ">";
print_bigint(b);
print "=";
m = bigint_gt(a, b)
if m then
  print "True";
else
  print "False";
end
print "\n";

