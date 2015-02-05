require "scanf.rb"
for i in (1 ..  3) do
                     (a, b) = STDIN.readline.split(" ").map{ |x| x.to_i(10) }
                     printf "a = %d b = %d\n", a, b
end

