require "scanf.rb"

=begin

La suite de fibonaci

=end

def fibo0( a, b, i )
    out0 = 0
    a2 = a
    b2 = b
    for j in (0 ..  i + 1) do
      out0 += a2
      tmp = b2
      b2 += a2
      a2 = tmp
    end
    return (out0)
end

a = 0
b = 0
i = 0
a=scanf("%d")[0]
scanf("%*\n")
b=scanf("%d")[0]
scanf("%*\n")
i=scanf("%d")[0]
printf "%d", fibo0(a, b, i)

