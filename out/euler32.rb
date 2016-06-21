require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def okdigits( ok, n )
  if n == 0 then
      return true
   else 
      digit = mod(n, 10)
      if ok[digit] then
          ok[digit] = false
          o = okdigits(ok, (n.to_f / 10).to_i)
          ok[digit] = true
          return o
       else 
          return false
      end
  end
end
count = 0
allowed = [*0..10-1].map { |i|
  
  next i != 0
  }
counted = [*0..100000-1].map { |j|
  
  next false
  }
for e in (1 ..  9) do
    allowed[e] = false
    for b in (1 ..  9) do
        if allowed[b] then
            allowed[b] = false
            be = mod(b * e, 10)
            if allowed[be] then
                allowed[be] = false
                for a in (1 ..  9) do
                    if allowed[a] then
                        allowed[a] = false
                        for c in (1 ..  9) do
                            if allowed[c] then
                                allowed[c] = false
                                for d in (1 ..  9) do
                                    if allowed[d] then
                                        allowed[d] = false
                                        # 2 * 3 digits 
                                        
                                        product = (a * 10 + b) * (c * 100 + d * 10 + e)
                                        if !counted[product] && okdigits(allowed, (product.to_f / 10).to_i) then
                                            counted[product] = true
                                            count += product
                                            printf "%d ", product
                                        end
                                        # 1  * 4 digits 
                                        
                                        product2 = b * (a * 1000 + c * 100 + d * 10 + e)
                                        if !counted[product2] && okdigits(allowed, (product2.to_f / 10).to_i) then
                                            counted[product2] = true
                                            count += product2
                                            printf "%d ", product2
                                        end
                                        allowed[d] = true
                                    end
                                    end
                                    allowed[c] = true
                                end
                                end
                                allowed[a] = true
                            end
                            end
                            allowed[be] = true
                        end
                        allowed[b] = true
                    end
                    end
                    allowed[e] = true
                    end
                    printf "%d\n", count
                    
                    