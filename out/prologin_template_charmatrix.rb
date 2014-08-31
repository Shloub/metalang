require "scanf.rb"
def programme_candidat( tableau, taille_x, taille_y )
    out_ = 0
    for i in (0 ..  taille_y - 1) do
      for j in (0 ..  taille_x - 1) do
        out_ += tableau[i][j].ord * (i + j * 2)
        printf "%c", tableau[i][j]
      end
      print "--\n";
    end
    return (out_);
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
    q=scanf("%c")[0];
    o[p] = q;
  end
  scanf("%*\n");
  l[m] = o;
end
tableau = l
printf "%d\n", programme_candidat(tableau, taille_x, taille_y)

