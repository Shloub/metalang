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

def programme_candidat( tableau, taille )
    out_ = 0
    for i in (0 ..  taille - 1) do
      out_ += tableau[i].ord * i
      printf "%c", tableau[i]
    end
    print "--\n";
    return (out_);
end

b = 0
b=scanf("%d")[0];
scanf("%*\n");
a = b
taille = a
d = [];
for e in (0 ..  taille - 1) do
  f = "_"
  f=scanf("%c")[0];
  d[e] = f;
end
scanf("%*\n");
c = d
tableau = c
printf "%d\n", programme_candidat(tableau, taille)

