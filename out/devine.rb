require "scanf.rb"
def devine0( nombre, tab, len )
  min0 = tab[0]
  max0 = tab[1]
  for i in (2 ..  len - 1) do
      if tab[i] > max0 || tab[i] < min0 then
          return false
      end
      if tab[i] < nombre then
          min0 = tab[i]
      end
      if tab[i] > nombre then
          max0 = tab[i]
      end
      if tab[i] == nombre && len != i + 1 then
          return false
      end
      end
      return true
  end
  nombre = scanf("%d")[0]
  scanf("%*\n")
  len = scanf("%d")[0]
  scanf("%*\n")
  tab = [*0..len-1].map { |i|
    
    tmp = scanf("%d")[0]
    scanf("%*\n")
    next tmp
    }
  if devine0(nombre, tab, len) then
      print "True"
   else 
      print "False"
  end
  
  