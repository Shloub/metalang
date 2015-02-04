require "scanf.rb"

def mktoto( v1 )
    t = {
      "foo" => v1,
      "bar" => 0,
      "blah" => 0}
    return (t);
end

def result( t, len )
    out0 = 0
    for j in (0 ..  len - 1) do
      t[j]["blah"] = t[j]["blah"] + 1
      out0 = out0 + t[j]["foo"] + t[j]["blah"] * t[j]["bar"] + t[j]["bar"] * t[j]["foo"]
    end
    return (out0);
end

t = [];
for i in (0 ..  4 - 1) do
  t[i] = mktoto(i)
end
t[0]["bar"]=scanf("%d")[0];
scanf("%*\n");
t[1]["blah"]=scanf("%d")[0];
titi = result(t, 4)
printf "%d%d", titi, t[2]["blah"]

