buffer =  ""
function readint()
    if buffer == "" then buffer = io.read("*line") end
    local num, buffer0 = string.match(buffer, '^([\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end

function cons( list, i )
  local out0 = {
    head=i,
    tail=list
  }
  return out0
end

function rev2( empty, acc, torev )
  if torev == empty
  then
    return acc
  else
    local acc2 = {
      head=torev.head,
      tail=acc
    }
    return rev2(empty, acc, torev.tail)
  end
end

function rev( empty, torev )
  return rev2(empty, empty, torev)
end

function test( empty )
  local list = empty
  local i = -1
  while i ~= 0
  do
  i = readint()
  if i ~= 0
  then
    list = cons(list, i);
  end
  end
end



