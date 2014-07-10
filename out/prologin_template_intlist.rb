require "scanf.rb"
def read_int(  )
    out_ = 0
    out_=scanf("%d")[0];
    scanf("%*\n");
    return (out_);
end

def read_int_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t = 0
      t=scanf("%d")[0];
      scanf("%*\n");
      tab[i] = t;
    end
    return (tab);
end

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
d = taille
e = [];
for f in (0 ..  d - 1) do
  g = 0
  g=scanf("%d")[0];
  scanf("%*\n");
  e[f] = g;
end
c = e
tableau = c
printf "%d\n", programme_candidat(tableau, taille)

