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

def read_char_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      tab[z] = read_char_line(x);
    end
    return (tab);
end

def programme_candidat( tableau, taille_x, taille_y )
    out_ = 0
    for i in (0 ..  taille_y - 1) do
      for j in (0 ..  taille_x - 1) do
        out_ += tableau[i][j].ord * (i + j * 2)
        a = tableau[i][j]
        printf "%c", a
      end
      print "--\n";
    end
    return (out_);
end

taille_x = read_int()
taille_y = read_int()
tableau = read_char_matrix(taille_x, taille_y)
b = programme_candidat(tableau, taille_x, taille_y)
printf "%d\n", b

