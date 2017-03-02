require "scanf.rb"
def programme_candidat( tableau, x, y )
  out0 = 0
  for i in (0 ..  y - 1) do
      for j in (0 ..  x - 1) do
          out0 += tableau[i][j] * (i * 2 + j)
          end
          end
          return out0
      end
      taille_x = STDIN.readline.to_i(10)
      taille_y = STDIN.readline.to_i(10)
      tableau = [*1..taille_y].map { |l| STDIN.readline.split(" ").map{ |x| x.to_i(10) } }
      printf "%d\n", programme_candidat(tableau, taille_x, taille_y)
      