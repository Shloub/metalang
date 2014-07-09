require "scanf.rb"

param = {
  "foo" => 0,
  "bar" => 0}
param["bar"]=scanf("%d")[0];
scanf("%*\n");
param["foo"]=scanf("%d")[0];
printf "%d", param["bar"] + param["foo"] * param["bar"]

