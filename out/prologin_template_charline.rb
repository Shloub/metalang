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
      a = tableau[i]
      printf "%c", a
    end
    print "--\n";
    return (out_);
end

taille = read_int()
tableau = read_char_line(taille)
b = programme_candidat(tableau, taille)
printf "%d\n", b

