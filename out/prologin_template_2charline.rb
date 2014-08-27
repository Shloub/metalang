require "scanf.rb"
def programme_candidat( tableau1, taille1, tableau2, taille2 )
    out_ = 0
    for i in (0 ..  taille1 - 1) do
      out_ += tableau1[i].ord * i
      printf "%c", tableau1[i]
    end
    print "--\n";
    for j in (0 ..  taille2 - 1) do
      out_ += tableau2[j].ord * j * 100
      printf "%c", tableau2[j]
    end
    print "--\n";
    return (out_);
end

b=scanf("%d")[0];
scanf("%*\n");
taille1 = b
d = [];
for e in (0 ..  taille1 - 1) do
  d[e]=scanf("%c")[0];
end
scanf("%*\n");
tableau1 = d
h=scanf("%d")[0];
scanf("%*\n");
taille2 = h
l = [];
for m in (0 ..  taille2 - 1) do
  l[m]=scanf("%c")[0];
end
scanf("%*\n");
tableau2 = l
printf "%d\n", programme_candidat(tableau1, taille1, tableau2, taille2)

