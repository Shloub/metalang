require "scanf.rb"
j = 0
for k in (0 ..  10) do
  j += k
  printf "%d\n", j
end
i = 4
while i < 10 do
  printf "%d", i
  i += 1
  j += i
end
printf "%d%dFIN TEST\n", j, i

