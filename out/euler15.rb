require "scanf.rb"
n = 10

=begin
 normalement on doit mettre 20 mais là on se tape un overflow 
=end

n += 1
tab = [];
for i in (0 ..  n - 1) do
  tab2 = [];
  for j in (0 ..  n - 1) do
    tab2[j] = 0;
  end
  tab[i] = tab2;
end
for l in (0 ..  n - 1) do
  tab[n - 1][l] = 1;
  tab[l][n - 1] = 1;
end
for o in (2 ..  n) do
  r = n - o
  for p in (2 ..  n) do
    q = n - p
    tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
  end
end
for m in (0 ..  n - 1) do
  for k in (0 ..  n - 1) do
    a = tab[m][k]
    printf "%d ", a
  end
  print "\n";
end
b = tab[0][0]
printf "%d\n", b

