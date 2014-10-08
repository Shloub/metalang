require "scanf.rb"

def cons( list, i )
    out0 = {
      "head" => i,
      "tail" => list}
    return (out0);
end

def rev2( empty, acc, torev )
    if torev == empty then
      return (acc);
    else
      acc2 = {
        "head" => torev["head"],
        "tail" => acc}
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



