
require "scanf.rb"

def exp_( a, b )
    if b == 0 then
      return (1);
    end
    if (b % 2) == 0 then
      o = exp_(a, b / 2)
      return (o * o);
    else
      return (a * exp_(a, b - 1));
    end
end

a = 0
b = 0
a=scanf("%d")[0];
scanf("%*\n");
b=scanf("%d")[0];
k = exp_(a, b)
printf "%d", k

