
require "scanf.rb"

def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

param = {"foo" => 0,
         "bar" => 0};
param["bar"]=scanf("%d")[0];
scanf("%*\n");
param["foo"]=scanf("%d")[0];
a = param["bar"] + param["foo"] * param["bar"]
printf "%d", a

