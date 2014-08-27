require "scanf.rb"
c = [];
for d in (0 ..  12 - 1) do
  e=scanf("%c")[0];
  c[d] = e;
end
scanf("%*\n");
str = c
for i in (0 ..  11) do
  printf "%c", str[i]
end

