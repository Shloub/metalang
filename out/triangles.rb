require "scanf.rb"
# Ce code a été généré par metalang#   Il gère les entrées sorties pour un programme dynamique classique#   dans les épreuves de prologin#on le retrouve ici : http://projecteuler.net/problem=18#
def find0( len, tab, cache, x, y )
  #
  #	Cette fonction est récursive
  #	
  
  if y == len - 1 then
      return tab[y][x]
  elsif x > y then
      return -10000
  elsif cache[y][x] != 0 then
      return cache[y][x]
  end
  result = 0
  out0 = find0(len, tab, cache, x, y + 1)
  out1 = find0(len, tab, cache, x + 1, y + 1)
  if out0 > out1 then
      result = out0 + tab[y][x]
  else 
      result = out1 + tab[y][x]
  end
  cache[y][x] = result
  return result
end
def find( len, tab )
  tab2 = [*0..len-1].map { |i|
    
    tab3 = [*0..i + 1-1].map { |j|
      
      next 0
      }
    next tab3
    }
  return find0(len, tab, tab2, 0, 0)
end
len = scanf("%d")[0]
scanf("%*\n")
tab = [*0..len-1].map { |i|
  
  tab2 = [*0..i + 1-1].map { |j|
    
    tmp = scanf("%d")[0]
    scanf("%*\n")
    next tmp
    }
  next tab2
  }
printf "%d\n", find(len, tab)
for k in (0 ..  len - 1) do
    for l in (0 ..  k) do
        printf "%d ", tab[k][l]
        end
        print "\n"
        end
        