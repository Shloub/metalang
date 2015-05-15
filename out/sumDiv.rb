require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def foo(  )
    a = 0
    
=begin
 test 
=end

    a += 1
    
=begin
 test 2 
=end

end

def foo2(  )
    
end

def foo3(  )
    if 1 == 1 then
      
    end
end

def sumdiv( n )
    
=begin
 On désire renvoyer la somme des diviseurs 
=end

    out0 = 0
    
=begin
 On déclare un entier qui contiendra la somme 
=end

    for i in (1 ..  n) do
      
=begin
 La boucle : i est le diviseur potentiel
=end

      if mod(n, i) == 0 then
        
=begin
 Si i divise 
=end

        out0 += i
        
=begin
 On incrémente 
=end

      else
        
=begin
 nop 
=end

      end
    end
    return (out0)
    
=begin
On renvoie out
=end

end


=begin
 Programme principal 
=end

n = 0
n=scanf("%d")[0]

=begin
 Lecture de l'entier 
=end

printf "%d", sumdiv(n)

