
require "scanf.rb"

def read_int_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t = 0
      t=scanf("%d")[0];
      scanf("%*\n");
      tab[i] = t;
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

l0 = read_int_line(1)
len = l0[0]
tab = read_int_line(len)
a = result(len, tab)
printf "%d", a

