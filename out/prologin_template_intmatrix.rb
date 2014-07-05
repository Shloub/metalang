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
      tab[z] = read_int_line(x);
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

taille_x = read_int()
taille_y = read_int()
tableau = read_int_matrix(taille_x, taille_y)
a = programme_candidat(tableau, taille_x, taille_y)
printf "%d\n", a

