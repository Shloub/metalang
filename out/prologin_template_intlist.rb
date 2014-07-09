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

taille = read_int()
tableau = read_int_line(taille)
printf "%d\n", programme_candidat(tableau, taille)

