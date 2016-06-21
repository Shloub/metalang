require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

i = 1
last = [*0..5-1].map { |j|
  
  c = scanf("%c")[0]
  d = c.ord - "0".ord
  i *= d
  next d
  }
max0 = i
index = 0
nskipdiv = 0
for k in (1 ..  995) do
    e = scanf("%c")[0]
    f = e.ord - "0".ord
    if f == 0 then
        i = 1
        nskipdiv = 4
     else 
        i *= f
        if nskipdiv < 0 then
            i = (i.to_f / last[index]).to_i
        end
        nskipdiv -= 1
    end
    last[index] = f
    index = mod(index + 1, 5)
    max0 = [max0, i].max
    end
    printf "%d\n", max0
    
    