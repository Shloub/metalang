require "scanf.rb"
def read_char_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      b = [];
      for c in (0 ..  x - 1) do
        d=scanf("%c")[0];
        b[c] = d;
      end
      scanf("%*\n");
      a = b
      tab[z] = a;
    end
    return (tab);
end

def programme_candidat( tableau, taille_x, taille_y )
    out_ = 0
    for i in (0 ..  taille_y - 1) do
      for j in (0 ..  taille_x - 1) do
        out_ += tableau[i][j].ord * (i + j * 2)
        printf "%c", tableau[i][j]
      end
      print "--\n";
    end
    return (out_);
end

f=scanf("%d")[0];
scanf("%*\n");
taille_x = f
h=scanf("%d")[0];
scanf("%*\n");
taille_y = h
tableau = read_char_matrix(taille_x, taille_y)
printf "%d\n", programme_candidat(tableau, taille_x, taille_y)

