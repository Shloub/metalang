require "scanf.rb"
def programme_candidat( tableau, taille )
    out0 = 0
    for i in (0 ..  taille - 1) do
      out0 += tableau[i].ord * i
      printf "%c", tableau[i]
    end
    print "--\n";
    return (out0);
end

taille = STDIN.readline.to_i(10)
tableau = STDIN.readline.split(//)
printf "%d\n", programme_candidat(tableau, taille)

