
require "scanf.rb"

def max2( a, b )
    if a > b then
      return (a);
    end
    return (b);
end

def nbPassePartout( n, passepartout, m, serrures )
    max_ancient = 0
    max_recent = 0
    for i in (0 ..  m - 1) do
      if (serrures[i][0] == -1) && (serrures[i][1] > max_ancient) then
        max_ancient = serrures[i][1];
      end
      if (serrures[i][0] == 1) && (serrures[i][1] > max_recent) then
        max_recent = serrures[i][1];
      end
    end
    max_ancient_pp = 0
    max_recent_pp = 0
    for i in (0 ..  n - 1) do
      pp = passepartout[i]
      if (pp[0] >= max_ancient) && (pp[1] >= max_recent) then
        return (1);
      end
      max_ancient_pp = max2(max_ancient_pp, pp[0]);
      max_recent_pp = max2(max_recent_pp, pp[1]);
    end
    if (max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent) then
      return (2);
    else
      return (0);
    end
end

n = 0
n=scanf("%d")[0];
scanf("%*\n");
passepartout = [];
for i in (0 ..  n - 1) do
  bg = 2
  out0 = [];
  for j in (0 ..  bg - 1) do
    out_ = 0
    out_=scanf("%d")[0];
    scanf("%*\n");
    out0[j] = out_;
  end
  passepartout[i] = out0;
end
m = 0
m=scanf("%d")[0];
scanf("%*\n");
serrures = [];
for i in (0 ..  m - 1) do
  bh = 2
  out0 = [];
  for j in (0 ..  bh - 1) do
    out_ = 0
    out_=scanf("%d")[0];
    scanf("%*\n");
    out0[j] = out_;
  end
  serrures[i] = out0;
end
bi = nbPassePartout(n, passepartout, m, serrures)
printf "%d", bi

