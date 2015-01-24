require "scanf.rb"
t = [];
for d in (0 ..  2 - 1) do
  t[d]=scanf("%d")[0];
  scanf("%*\n");
end
printf "%d - %d\n", t[0], t[1]

