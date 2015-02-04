require "scanf.rb"
def eratostene( t, max0 )
    sum = 0
    for i in (2 ..  max0 - 1) do
      if t[i] == i then
        sum += i
        if (max0.to_f / i).to_i > i then
          j = i * i
          while j < max0 && j > 0 do
            t[j] = 0
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
  t[i] = i
end
t[1] = 0
printf "%d\n", eratostene(t, n)

