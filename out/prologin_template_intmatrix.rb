require "scanf.rb"
def read_int_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      b = [];
      for c in (0 ..  x - 1) do
        d=scanf("%d")[0];
        scanf("%*\n");
        b[c] = d;
      end
      a = b
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

f=scanf("%d")[0];
scanf("%*\n");
taille_x = f
h=scanf("%d")[0];
scanf("%*\n");
taille_y = h
tableau = read_int_matrix(taille_x, taille_y)
printf "%d\n", programme_candidat(tableau, taille_x, taille_y)

