require "scanf.rb"

def mktoto( v1 )
    t_ = {"foo" => v1,
          "bar" => 0,
          "blah" => 0};
    return (t_);
end

def result( t_, len )
    out_ = 0
    for j in (0 ..  len - 1) do
      t_[j]["blah"] = t_[j]["blah"] + 1;
      out_ = out_ + t_[j]["foo"] + t_[j]["blah"] * t_[j]["bar"] + t_[j]["bar"] * t_[j]["foo"];
    end
    return (out_);
end

a = 4
t_ = [];
for i in (0 ..  a - 1) do
  t_[i] = mktoto(i);
end
t_[0]["bar"]=scanf("%d")[0];
scanf("%*\n");
t_[1]["blah"]=scanf("%d")[0];
b = result(t_, 4)
printf "%d", b
c = t_[2]["blah"]
printf "%d", c

