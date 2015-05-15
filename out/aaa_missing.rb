require "scanf.rb"

=begin

  Ce test a été généré par Metalang.

=end

def result( len, tab )
    tab2 = [*0..len - 1].map { |i|
      next (false)
      }
    for i1 in (0 ..  len - 1) do
      printf "%d ", tab[i1]
      tab2[tab[i1]] = true
    end
    print "\n"
    for i2 in (0 ..  len - 1) do
      if !tab2[i2] then
        return (i2)
      end
    end
    return (-1)
end

len = STDIN.readline.to_i(10)
printf "%d\n", len
tab = STDIN.readline.split(" ").map{ |x| x.to_i(10) }
printf "%d\n", result(len, tab)

