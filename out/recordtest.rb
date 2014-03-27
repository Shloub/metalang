require "scanf.rb"

b = {"foo" => 0,
     "bar" => 0};
param = b
param["bar"]=scanf("%d")[0];
scanf("%*\n");
param["foo"]=scanf("%d")[0];
a = param["bar"] + param["foo"] * param["bar"]
printf "%d", a

