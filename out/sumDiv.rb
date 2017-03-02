require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def foo(  )
  a = 0
  # test 
  
  a += 1
  # test 2 
  
end
def foo2(  )
  
end
def foo3(  )
  if 1 == 1 then
      
  end
end
def sumdiv( n )
  # On désire renvoyer la somme des diviseurs 
  
  out0 = 0
  # On déclare un entier qui contiendra la somme 
  
  for i in (1 ..  n) do
      # La boucle : i est le diviseur potentiel
      
      if mod(n, i) == 0 then
          # Si i divise 
          
          out0 += i
          # On incrémente 
          
      else 
          # nop 
          
      end
      end
      return out0
      #On renvoie out
      
  end
  # Programme principal 
  
  n = 0
  n = scanf("%d")[0]
  # Lecture de l'entier 
  
  printf "%d", sumdiv(n)
  