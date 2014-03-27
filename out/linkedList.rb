require "scanf.rb"

def cons( list, i )
    a = {"head" => i,
         "tail" => list};
    out_ = a
    return (out_);
end

def rev2( empty, acc, torev )
    if torev == empty then
      return (acc);
    else
      b = {"head" => torev["head"],
           "tail" => acc};
      acc2 = b
      return (rev2(empty, acc, torev["tail"]));
    end
end

def rev( empty, torev )
    return (rev2(empty, empty, torev));
end

def test( empty )
    list = empty
    i = -1
    while i != 0 do
      i=scanf("%d")[0];
      if i != 0 then
        list = cons(list, i);
      end
    end
end



