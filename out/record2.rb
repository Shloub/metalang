
require "scanf.rb"

def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def mktoto( v1 )
    t_ = {"foo" => v1,
          "bar" => 0,
          "blah" => 0};
    return (t_);
end

def result( t_ )
    t_["blah"] += 1
    return (t_["foo"] + t_["blah"] * t_["bar"] + t_["bar"] * t_["foo"]);
end

t_ = mktoto(4)
t_["bar"]=scanf("%d")[0];
scanf("%*\n");
t_["blah"]=scanf("%d")[0];
a = result(t_)
printf "%d", a
b = t_["blah"]
printf "%d", b

