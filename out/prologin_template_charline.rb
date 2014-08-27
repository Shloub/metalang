require "scanf.rb"
def programme_candidat( tableau, taille )
    out_ = 0
    for i in (0 ..  taille - 1) do
      out_ += tableau[i].ord * i
      printf "%c", tableau[i]
    end
    print "--\n";
    return (out_);
end

b=scanf("%d")[0];
scanf("%*\n");
taille = b
d = [];
for e in (0 ..  taille - 1) do
  f=scanf("%c")[0];
  d[e] = f;
end
scanf("%*\n");
tableau = d
printf "%d\n", programme_candidat(tableau, taille)

