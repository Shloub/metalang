
require "scanf.rb"


=begin
 Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin

=end

def find0( len, tab, cache, x, y )
    
=begin

	Cette fonction est récursive
	
=end

    if y == (len - 1) then
      return (tab[y][x]);
    elsif x > y then
      return (100000);
    elsif cache[y][x] != 0 then
      return (cache[y][x]);
    end
    result = 0
    out0 = find0(len, tab, cache, x, y + 1)
    out1 = find0(len, tab, cache, x + 1, y + 1)
    if out0 < out1 then
      result = out0 + tab[y][x];
    else
      result = out1 + tab[y][x];
    end
    cache[y][y] = result;
    return (result);
end

def find( len, tab )
    tab2 = [];
    for i in (0 ..  len - 1) do
      bm = i + 1
      tab3 = [];
      for j in (0 ..  bm - 1) do
        tab3[j] = 0;
      end
      tab2[i] = tab3;
    end
    return (find0(len, tab, tab2, 0, 0));
end

len = 0
len=scanf("%d")[0];
scanf("%*\n");
tab = [];
for i in (0 ..  len - 1) do
  bn = i + 1
  tab2 = [];
  for j in (0 ..  bn - 1) do
    tmp = 0
    tmp=scanf("%d")[0];
    scanf("%*\n");
    tab2[j] = tmp;
  end
  tab[i] = tab2;
end
bo = find(len, tab)
printf "%d", bo
for i in (0 ..  len - 1) do
  for j in (0 ..  i) do
    bp = tab[i][j]
    printf "%d", bp
  end
  printf "%s", "\n"
end

