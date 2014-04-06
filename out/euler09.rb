require "scanf.rb"


=begin

	a + b + c = 1000 && a * a + b * b = c * c
	
=end

for a in (1 ..  1000) do
  for b in (a + 1 ..  1000) do
    c = 1000 - a - b
    a2b2 = a * a + b * b
    cc = c * c
    if cc == a2b2 && c > a then
      printf "%d\n%d\n%d\n", a, b, c
      d = a * b * c
      printf "%d\n", d
    end
  end
end

