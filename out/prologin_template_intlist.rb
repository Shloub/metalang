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

