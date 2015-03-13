require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def triangle( n )
    if (mod(n, 2)) == 0 then
      return (((n.to_f / 2).to_i) * (n + 1))
    else
      return (n * (((n + 1).to_f / 2).to_i))
    end
end

def penta( n )
    if (mod(n, 2)) == 0 then
      return (((n.to_f / 2).to_i) * (3 * n - 1))
    else
      return ((((3 * n - 1).to_f / 2).to_i) * n)
    end
end

def hexa( n )
    return (n * (2 * n - 1))
end

def findPenta2( n, a, b )
    if b == a + 1 then
      return (penta(a) == n || penta(b) == n)
    end
    c = ((a + b).to_f / 2).to_i
    p = penta(c)
    if p == n then
      return (true)
    elsif p < n then
      return (findPenta2(n, c, b))
    else
      return (findPenta2(n, a, c))
    end
end

def findHexa2( n, a, b )
    if b == a + 1 then
      return (hexa(a) == n || hexa(b) == n)
    end
    c = ((a + b).to_f / 2).to_i
    p = hexa(c)
    if p == n then
      return (true)
    elsif p < n then
      return (findHexa2(n, c, b))
    else
      return (findHexa2(n, a, c))
    end
end

for n in (285 ..  55385) do
  t = triangle(n)
  if findPenta2(t, (n.to_f / 5).to_i, n) && findHexa2(t, (n.to_f / 5).to_i, (n.to_f / 2).to_i + 10) then
    printf "%d\n%d\n", n, t
  end
end

