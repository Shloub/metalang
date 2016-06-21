require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end





len = STDIN.readline.to_i(10)
printf "%d=len\n", len
tab = STDIN.readline.split(" ").map{ |x| x.to_i(10) }
for i in (0 ..  len - 1) do
    printf "%d=>%d ", i, tab[i]
    end
    print "\n"
    tab2 = STDIN.readline.split(" ").map{ |x| x.to_i(10) }
    for i_ in (0 ..  len - 1) do
        printf "%d==>%d ", i_, tab2[i_]
        end
        strlen = STDIN.readline.to_i(10)
        printf "%d=strlen\n", strlen
        tab4 = STDIN.readline.split(//)
        for i3 in (0 ..  strlen - 1) do
            tmpc = tab4[i3]
            c = tmpc.ord
            printf "%c:%d ", tmpc, c
            if tmpc != " " then
                c = mod(c - "a".ord + 13, 26) + "a".ord
            end
            tab4[i3] = (c).chr
            end
            for j in (0 ..  strlen - 1) do
                printf "%c", tab4[j]
                end
                
                