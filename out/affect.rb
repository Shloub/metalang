require "scanf.rb"


def mktoto( v1 )
  t = {"foo" => v1, "bar" => v1, "blah" => v1}
  return t
end

def mktoto2( v1 )
  t = {"foo" => v1 + 3, "bar" => v1 + 2, "blah" => v1 + 1}
  return t
end

def result( t_, t2_ )
  t = t_
  t2 = t2_
  t3 = {"foo" => 0, "bar" => 0, "blah" => 0}
  t3 = t2
  t = t2
  t2 = t3
  t["blah"] += 1
  len = 1
  cache0 = [*0..len-1].map { |i|
    
    next -i
    }
  cache1 = [*0..len-1].map { |j|
    
    next j
    }
  cache2 = cache0
  cache0 = cache1
  cache2 = cache0
  return t["foo"] + t["blah"] * t["bar"] + t["bar"] * t["foo"]
end
t = mktoto(4)
t2 = mktoto(5)
t["bar"] = scanf("%d")[0]
scanf("%*\n")
t["blah"] = scanf("%d")[0]
scanf("%*\n")
t2["bar"] = scanf("%d")[0]
scanf("%*\n")
t2["blah"] = scanf("%d")[0]
printf "%d%d", result(t, t2), t["blah"]

