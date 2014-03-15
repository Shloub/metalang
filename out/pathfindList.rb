require "scanf.rb"
def pathfind_aux( cache, tab, len, pos )
    if pos >= len - 1 then
      return (0);
    elsif cache[pos] != -1 then
      return (cache[pos]);
    else
      cache[pos] = len * 2;
      posval = pathfind_aux(cache, tab, len, tab[pos])
      oneval = pathfind_aux(cache, tab, len, pos + 1)
      out_ = 0
      if posval < oneval then
        out_ = 1 + posval;
      else
        out_ = 1 + oneval;
      end
      cache[pos] = out_;
      return (out_);
    end
end

def pathfind( tab, len )
    cache = [];
    for i in (0 ..  len - 1) do
      cache[i] = -1;
    end
    return (pathfind_aux(cache, tab, len, 0));
end

len = 0
len=scanf("%d")[0];
scanf("%*\n");
tab = [];
for i in (0 ..  len - 1) do
  tmp = 0
  tmp=scanf("%d")[0];
  scanf("%*\n");
  tab[i] = tmp;
end
result = pathfind(tab, len)
printf "%d", result

