
require "scanf.rb"

def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def read_int(  )
    out_ = 0
    out_=scanf("%d")[0];
    scanf("%*\n");
    return (out_);
end

def read_int_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t_ = 0
      t_=scanf("%d")[0];
      scanf("%*\n");
      tab[i] = t_;
    end
    return (tab);
end


=begin

  Ce test a été généré par Metalang.

=end

def result( len, tab )
    tab2 = [];
    for i in (0 ..  len - 1) do
      tab2[i] = false;
    end
    for i1 in (0 ..  len - 1) do
      tab2[tab[i1]] = true;
    end
    for i2 in (0 ..  len - 1) do
      if not(tab2[i2]) then
        return (i2);
      end
    end
    return (-1);
end

len = read_int()
printf "%d\n", len
tab = read_int_line(len)
a = result(len, tab)
printf "%d", a

