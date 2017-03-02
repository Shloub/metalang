require "scanf.rb"

bar_ = STDIN.readline.to_i(10)
t = {"foo" => STDIN.readline.split(" ").map{ |x| x.to_i(10) }, "bar" => bar_}
(a, b) = t["foo"]
printf "%d %d %d\n", a, b, t["bar"]
