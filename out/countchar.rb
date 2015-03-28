require "scanf.rb"
def nth( tab, tofind, len )
    out0 = 0
    for i in (0 ..  len - 1) do
      if tab[i] == tofind then
        out0 += 1
      end
    end
    return (out0)
end

len = 0
len=scanf("%d")[0]
scanf("%*\n")
tofind = "\u0000"
tofind=scanf("%c")[0]
scanf("%*\n")
tab = [*0..len - 1].map { |i|
  tmp = "\u0000"
  tmp=scanf("%c")[0]
  next (tmp)
  }
result = nth(tab, tofind, len)
printf "%d", result

