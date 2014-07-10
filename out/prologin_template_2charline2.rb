require "scanf.rb"
def read_int(  )
    out_ = 0
    out_=scanf("%d")[0];
    scanf("%*\n");
    return (out_);
end

def read_char_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t = "_"
      t=scanf("%c")[0];
      tab[i] = t;
    end
    scanf("%*\n");
    return (tab);
end

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

b = 0
b=scanf("%d")[0];
scanf("%*\n");
a = b
taille1 = a
d = 0
d=scanf("%d")[0];
scanf("%*\n");
c = d
taille2 = c
f = [];
for g in (0 ..  taille1 - 1) do
  h = "_"
  h=scanf("%c")[0];
  f[g] = h;
end
scanf("%*\n");
e = f
tableau1 = e
l = [];
for m in (0 ..  taille2 - 1) do
  o = "_"
  o=scanf("%c")[0];
  l[m] = o;
end
scanf("%*\n");
k = l
tableau2 = k
printf "%d\n", programme_candidat(tableau1, taille1, tableau2, taille2)

