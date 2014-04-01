require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def max2( a, b )
    if a > b then
      return (a);
    end
    return (b);
end


def read_bigint(  )
    len = 0
    len=scanf("%d")[0];
    scanf("%*\n");
    sign = '_'
    sign=scanf("%c")[0];
    scanf("%*\n");
    chiffres = [];
    for d in (0 ..  len - 1) do
      c = '_'
      c=scanf("%c")[0];
      chiffres[d] = c.ord - '0'.ord;
    end
    for i in (0 ..  ((len - 1).to_f / 2).to_i) do
      tmp = chiffres[i]
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    end
    scanf("%*\n");
    out_ = {
      "bigint_sign" => sign == '+',
      "bigint_len" => len,
      "bigint_chiffres" => chiffres}
    return (out_);
end

def print_bigint( a )
    if not(a["bigint_sign"]) then
      printf "%c", '-'
    end
    for i in (0 ..  a["bigint_len"] - 1) do
      e = a["bigint_chiffres"][a["bigint_len"] - 1 - i]
      printf "%d", e
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
            return (a["bigint_sign"]);
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

    len = max2(a["bigint_len"], b["bigint_len"]) + 1
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
    if chiffres[len - 1] == 0 then
      len -= 1
    end
    out_ = {
      "bigint_sign" => true,
      "bigint_len" => len,
      "bigint_chiffres" => chiffres}
    return (out_);
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
    out_ = {
      "bigint_sign" => true,
      "bigint_len" => len,
      "bigint_chiffres" => chiffres}
    return (out_);
end

def neg_bigint( a )
    out_ = {
      "bigint_sign" => not(a["bigint_sign"]),
      "bigint_len" => a["bigint_len"],
      "bigint_chiffres" => a["bigint_chiffres"]}
    return (out_);
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
      if chiffres[len - 1] == 0 then
        len -= 1
      end
    end
    out_ = {
      "bigint_sign" => a["bigint_sign"] == b["bigint_sign"],
      "bigint_len" => len,
      "bigint_chiffres" => chiffres}
    return (out_);
end

def bigint_premiers_chiffres( a, i )
    out_ = {
      "bigint_sign" => a["bigint_sign"],
      "bigint_len" => i,
      "bigint_chiffres" => a["bigint_chiffres"]}
    return (out_);
end

def bigint_shift( a, i )
    f = a["bigint_len"] + i
    chiffres = [];
    for k in (0 ..  f - 1) do
      if k >= i then
        chiffres[k] = a["bigint_chiffres"][k - i];
      else
        chiffres[k] = 0;
      end
    end
    out_ = {
      "bigint_sign" => a["bigint_sign"],
      "bigint_len" => a["bigint_len"] + i,
      "bigint_chiffres" => chiffres}
    return (out_);
end

def mul_bigint( aa, bb )
    if aa["bigint_len"] < 3 || bb["bigint_len"] < 3 then
      return (mul_bigint_cp(aa, bb));
    end
    
=begin
 Algorithme de Karatsuba 
=end

    split = (max2(aa["bigint_len"], bb["bigint_len"]).to_f / 2).to_i
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
Exp

=end

a = read_bigint()
b = read_bigint()
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
g = bigint_gt(a, b)
if g then
  print "True";
else
  print "False";
end
print "\n";

