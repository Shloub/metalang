require "scanf.rb"
def programme_candidat( tableau1, taille1, tableau2, taille2 )
    out0 = 0
    for i in (0 ..  taille1 - 1) do
      out0 += tableau1[i].ord * i
      printf "%c", tableau1[i]
    end
    print "--\n";
    for j in (0 ..  taille2 - 1) do
      out0 += tableau2[j].ord * j * 100
      printf "%c", tableau2[j]
    end
    print "--\n";
    return (out0);
end

b=scanf("%d")[0];
scanf("%*\n");
taille1 = b
d=scanf("%d")[0];
scanf("%*\n");
taille2 = d
f = [];
for g in (0 ..  taille1 - 1) do
  f[g]=scanf("%c")[0];
end
scanf("%*\n");
tableau1 = f
l = [];
for m in (0 ..  taille2 - 1) do
  l[m]=scanf("%c")[0];
end
scanf("%*\n");
tableau2 = l
printf "%d\n", programme_candidat(tableau1, taille1, tableau2, taille2)

