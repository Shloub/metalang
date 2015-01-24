require "scanf.rb"
c = [];
for d in (0 ..  2 - 1) do
  c[d]=scanf("%d")[0];
  scanf("%*\n");
end
t = c
printf "%d - %d\n", t[0], t[1]

