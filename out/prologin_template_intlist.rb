require "scanf.rb"
def programme_candidat( tableau, taille )
    out0 = 0
    for i in (0 ..  taille - 1) do
      out0 += tableau[i]
    end
    return (out0);
end

b=scanf("%d")[0];
scanf("%*\n");
taille = b
d = [];
for e in (0 ..  taille - 1) do
  d[e]=scanf("%d")[0];
  scanf("%*\n");
end
tableau = d
printf "%d\n", programme_candidat(tableau, taille)

