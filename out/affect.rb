require "scanf.rb"

=begin

Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement

=end


def mktoto( v1 )
    t__ = {"foo" => v1,
           "bar" => v1,
           "blah" => v1};
    return (t__);
end

def result( t_, t2_ )
    t__ = t_
    t2 = t2_
    t3 = {"foo" => 0,
          "bar" => 0,
          "blah" => 0};
    t3 = t2;
    t__ = t2;
    t2 = t3;
    t__["blah"] += 1
    len = 1
    cache0 = [];
    for i in (0 ..  len - 1) do
      cache0[i] = -i;
    end
    cache1 = [];
    for j in (0 ..  len - 1) do
      cache1[j] = j;
    end
    cache2 = cache0
    cache0 = cache1;
    cache2 = cache0;
    return (t__["foo"] + t__["blah"] * t__["bar"] + t__["bar"] * t__["foo"]);
end

t__ = mktoto(4)
t2 = mktoto(5)
t__["bar"]=scanf("%d")[0];
scanf("%*\n");
t__["blah"]=scanf("%d")[0];
scanf("%*\n");
t2["bar"]=scanf("%d")[0];
scanf("%*\n");
t__["blah"]=scanf("%d")[0];
a = result(t__, t2)
printf "%d", a
b = t__["blah"]
printf "%d", b

