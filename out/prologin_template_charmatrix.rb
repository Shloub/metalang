require "scanf.rb"
def programme_candidat( tableau, taille_x, taille_y )
    out0 = 0
    for i in (0 ..  taille_y - 1) do
      for j in (0 ..  taille_x - 1) do
        out0 += tableau[i][j].ord * (i + j * 2)
        printf "%c", tableau[i][j]
      end
      print "--\n"
    end
    return (out0)
end

taille_x = STDIN.readline.to_i(10)
taille_y = STDIN.readline.to_i(10)
a = [*0..taille_y - 1].map { |b|
  next (STDIN.readline.split(//))
  }
tableau = a
printf "%d\n", programme_candidat(tableau, taille_x, taille_y)

