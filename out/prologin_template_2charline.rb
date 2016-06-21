require "scanf.rb"



def programme_candidat( tableau1, taille1, tableau2, taille2 )
  out0 = 0
  for i in (0 ..  taille1 - 1) do
      out0 += tableau1[i].ord * i
      printf "%c", tableau1[i]
      end
      print "--\n"
      for j in (0 ..  taille2 - 1) do
          out0 += tableau2[j].ord * j * 100
          printf "%c", tableau2[j]
          end
          print "--\n"
          return out0
      end
      taille1 = STDIN.readline.to_i(10)
      tableau1 = STDIN.readline.split(//)
      taille2 = STDIN.readline.to_i(10)
      tableau2 = STDIN.readline.split(//)
      printf "%d\n", programme_candidat(tableau1, taille1, tableau2, taille2)
      
      