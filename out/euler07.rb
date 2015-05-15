require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def divisible( n, t, size )
    for i in (0 ..  size - 1) do
      if mod(n, t[i]) == 0 then
        return (true)
      end
    end
    return (false)
end

def find( n, t, used, nth )
    while used != nth do
      if divisible(n, t, used) then
        n += 1
      else
        t[used] = n
        n += 1
        used += 1
      end
    end
    return (t[used - 1])
end

n = 10001
t = [*0..n - 1].map { |i|
  next (2)
  }
printf "%d\n", find(3, t, 1, n)

