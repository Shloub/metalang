require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def chiffre_sort( a )
  if a < 10 then
      return a
  else 
      b = chiffre_sort((a.to_f / 10).to_i)
      c = mod(a, 10)
      d = mod(b, 10)
      e = (b.to_f / 10).to_i
      if c < d then
          return c + b * 10
      else 
          return d + chiffre_sort(c + e * 10) * 10
      end
  end
end
def same_numbers( a, b, c, d, e, f )
  ca = chiffre_sort(a)
  return ca == chiffre_sort(b) && ca == chiffre_sort(c) && ca == chiffre_sort(d) && ca == chiffre_sort(e) && ca == chiffre_sort(f)
end
num = 142857
if same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5) then
    printf "%d %d %d %d %d %d\n", num, num * 2, num * 3, num * 4, num * 5, num * 6
end
