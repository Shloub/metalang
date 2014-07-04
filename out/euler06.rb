require "scanf.rb"
lim = 100
sum = ((lim * (lim + 1)).to_f / 2).to_i
carressum = sum * sum
sumcarres = ((lim * (lim + 1) * (2 * lim + 1)).to_f / 6).to_i
a = carressum - sumcarres
printf "%d", a

