
require "scanf.rb"


def max2( a, b )
    if a > b then
      return (a);
    end
    return (b);
end


def read_big_int(  )
    print "read_big_int";
    len = 0
    len=scanf("%d")[0];
    scanf("%*\n");
    printf "%d=len ", len
    sign = '_'
    sign=scanf("%c")[0];
    printf "%c=sign\n", sign
    chiffres = [];
    for d in (0 ..  len - 1) do
      c = '_'
      c=scanf("%c")[0];
      printf "%c=c\n", c
      chiffres[d] = c.ord - '0'.ord;
    end
    for i in (0 ..  len / 2) do
      tmp = chiffres[i]
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    end
    scanf("%*\n");
    out_ = {"sign" => sign == '+',
            "chiffres_len" => len,
            "chiffres" => chiffres};
    return (out_);
end

def print_big_int( a )
    if a["sign"] then
      print "+";
    else
      print "-";
    end
    for i in (0 ..  a["chiffres_len"] - 1) do
      e = a["chiffres"][i]
      printf "%d", e
    end
end

def neg_big_int( a )
    out_ = {"sign" => not(a["sign"]),
            "chiffres_len" => a["chiffres_len"],
            "chiffres" => a["chiffres"]};
    return (out_);
end

def add_big_int( a, b )
    len = max2(a["chiffres_len"], b["chiffres_len"]) + 1
    retenue = 0
    sign = true
    chiffres = [];
    for i in (0 ..  len - 1) do
      tmp = retenue
      if i < a["chiffres_len"] then
        tmp += a["chiffres"][i]
      end
      if i < b["chiffres_len"] then
        tmp += b["chiffres"][i]
      end
      retenue = tmp / 10;
      chiffres[i] = tmp % 10;
    end
    out_ = {"sign" => sign,
            "chiffres_len" => len,
            "chiffres" => chiffres};
    return (out_);
end


=begin

def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end

=end

a = read_big_int()
b = read_big_int()
print_big_int(add_big_int(a, b));

