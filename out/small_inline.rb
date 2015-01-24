require "scanf.rb"
c = [];
for d in (0 ..  2 - 1) do
  c[d]=scanf("%d")[0];
  scanf("%*\n");
end
printf "%d - %d\n", c[0], c[1]

