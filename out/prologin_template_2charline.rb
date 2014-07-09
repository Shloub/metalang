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

def programme_candidat( tableau1, taille1, tableau2, taille2 )
    out_ = 0
    for i in (0 ..  taille1 - 1) do
      out_ += tableau1[i].ord * i
      printf "%c", tableau1[i]
    end
    print "--\n";
    for j in (0 ..  taille2 - 1) do
      out_ += tableau2[j].ord * j * 100
      printf "%c", tableau2[j]
    end
    print "--\n";
    return (out_);
end

taille1 = read_int()
tableau1 = read_char_line(taille1)
taille2 = read_int()
tableau2 = read_char_line(taille2)
printf "%d\n", programme_candidat(tableau1, taille1, tableau2, taille2)

