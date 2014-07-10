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

def read_int_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      b = x
      c = [];
      for d in (0 ..  b - 1) do
        e = 0
        e=scanf("%d")[0];
        scanf("%*\n");
        c[d] = e;
      end
      a = c
      tab[z] = a;
    end
    return (tab);
end

def programme_candidat( tableau, x, y )
    out_ = 0
    for i in (0 ..  y - 1) do
      for j in (0 ..  x - 1) do
        out_ += tableau[i][j] * (i * 2 + j)
      end
    end
    return (out_);
end

g = 0
g=scanf("%d")[0];
scanf("%*\n");
f = g
taille_x = f
k = 0
k=scanf("%d")[0];
scanf("%*\n");
h = k
taille_y = h
tableau = read_int_matrix(taille_x, taille_y)
printf "%d\n", programme_candidat(tableau, taille_x, taille_y)

