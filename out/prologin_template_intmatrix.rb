require "scanf.rb"
def programme_candidat( tableau, x, y )
    out0 = 0
    for i in (0 ..  y - 1) do
      for j in (0 ..  x - 1) do
        out0 += tableau[i][j] * (i * 2 + j)
      end
    end
    return (out0);
end

f=scanf("%d")[0];
scanf("%*\n");
taille_x = f
h=scanf("%d")[0];
scanf("%*\n");
taille_y = h
l = [];
for m in (0 ..  taille_y - 1) do
  o = [];
  for p in (0 ..  taille_x - 1) do
    q=scanf("%d")[0];
    scanf("%*\n");
    o[p] = q;
  end
  l[m] = o;
end
tableau = l
printf "%d\n", programme_candidat(tableau, taille_x, taille_y)

