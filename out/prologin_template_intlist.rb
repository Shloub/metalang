require "scanf.rb"
def programme_candidat( tableau, taille )
    out_ = 0
    for i in (0 ..  taille - 1) do
      out_ += tableau[i]
    end
    return (out_);
end

b = 0
b=scanf("%d")[0];
scanf("%*\n");
a = b
taille = a
d = [];
for e in (0 ..  taille - 1) do
  f = 0
  f=scanf("%d")[0];
  scanf("%*\n");
  d[e] = f;
end
c = d
tableau = c
printf "%d\n", programme_candidat(tableau, taille)

