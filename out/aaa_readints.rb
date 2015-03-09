require "scanf.rb"
len = STDIN.readline.to_i(10)
printf "%d=len\n", len
tab1 = STDIN.readline.split(" ").map{ |x| x.to_i(10) }
for i in (0 ..  len - 1) do
  printf "%d=>%d\n", i, tab1[i]
end
len = STDIN.readline.to_i(10)
tab2 = [*1..len - 1].map { |l| STDIN.readline.split(" ").map{ |x| x.to_i(10) } }
for i in (0 ..  len - 2) do
  for j in (0 ..  len - 1) do
    printf "%d ", tab2[i][j]
  end
  print "\n"
end

