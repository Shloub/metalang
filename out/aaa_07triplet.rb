require "scanf.rb"
for i in (1 ..  3) do
                     (a, b, c) = STDIN.readline.split(" ").map{ |x| x.to_i(10) }
                     printf "a = %d b = %dc =%d\n", a, b, c
end
l = STDIN.readline.split(" ").map{ |x| x.to_i(10) }
for j in (0 ..  9) do
  printf "%d\n", l[j]
end

