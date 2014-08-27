require "scanf.rb"

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

b=scanf("%d")[0];
scanf("%*\n");
len = b
printf "%d\n", len
d = [];
for e in (0 ..  len - 1) do
  f=scanf("%d")[0];
  scanf("%*\n");
  d[e] = f;
end
tab = d
printf "%d", result(len, tab)

