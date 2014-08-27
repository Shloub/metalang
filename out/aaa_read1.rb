require "scanf.rb"
c = [];
for d in (0 ..  12 - 1) do
  c[d]=scanf("%c")[0];
end
scanf("%*\n");
str = c
for i in (0 ..  11) do
  printf "%c", str[i]
end

