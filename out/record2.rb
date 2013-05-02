
require "scanf.rb"


def mktoto( v1 )
    t = {"foo" => v1,
         "bar" => 0,
         "blah" => 0};
    return (t);
end

def result( t )
    t["blah"] += 1;
    return (t["foo"] + t["blah"] * t["bar"] + t["bar"] * t["foo"]);
end

t = mktoto(4)
t["bar"]=scanf("%d")[0];
scanf("%*\n");
t["blah"]=scanf("%d")[0];
q = result(t)
printf "%d", q
r = t["blah"]
printf "%d", r

