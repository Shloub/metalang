require "scanf.rb"
def eratostene( t, max_ )
    sum = 0
    for i in (2 ..  max_ - 1) do
      if t[i] == i then
        sum += i
        j = i * i
        
=begin

			detect overflow
			
=end

        if (j.to_f / i).to_i == i then
          while j < max_ && j > 0 do
            t[j] = 0;
            j += i
          end
        end
      end
    end
    return (sum);
end

n = 100000

=begin
 normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 
=end

t = [];
for i in (0 ..  n - 1) do
  t[i] = i;
end
t[1] = 0;
a = eratostene(t, n)
printf "%d\n", a

