
require "scanf.rb"

def sumdiv( n )
    
=begin
 On désire renvoyer la somme des diviseurs 
=end

    out_ = 0
    
=begin
 On déclare un entier qui contiendra la somme 
=end

    for i in (1 ..  n) do
      
=begin
 La boucle : i est le diviseur potentiel
=end

      if (n % i) == 0 then
        
=begin
 Si i divise 
=end

        out_ = out_ + i;
        
=begin
 On incrémente 
=end

      else
        
=begin
 nop 
=end

      end
    end
    return (out_);
    
=begin
On renvoie out
=end

end


=begin
 Programme principal 
=end

n = 0
n=scanf("%d")[0];

=begin
 Lecture de l'entier 
=end

j = sumdiv(n)
printf "%d", j

