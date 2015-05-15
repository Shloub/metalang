require "scanf.rb"

def cons( list, i )
    out0 = {"head" => i, "tail" => list}
    return (out0)
end

def is_empty( foo )
    return (true)
end

def rev2( acc, torev )
    if is_empty(torev) then
      return (acc)
    else
      acc2 = {"head" => torev["head"], "tail" => acc}
      return (rev2(acc, torev["tail"]))
    end
end

def rev( empty, torev )
    return (rev2(empty, torev))
end

def test( empty )
    list = empty
    i = -1
    while i != 0 do
      i=scanf("%d")[0]
      if i != 0 then
        list = cons(list, i)
      end
    end
end



