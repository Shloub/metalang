buffer =  ""
function readint()
    if buffer == "" then buffer = io.read("*line") end
    local num, buffer0 = string.match(buffer, '^([\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end

function stdinsep()
    if buffer == "" then buffer = io.read("*line") end
    if buffer ~= nil then buffer = string.gsub(buffer, '^%s*', "") end
end

function mktoto( v1 )
  local t = {
    foo=v1,
    bar=0,
    blah=0
  }
  return t
end

function result( t, len )
  local out0 = 0
  for j = 0,len - 1 do
  t[j].blah = t[j].blah + 1;
    out0 = out0 + t[j].foo + t[j].blah * t[j].bar + t[j].bar * t[j].foo;
    end
    return out0
  end
  
  
  local t = {}
  for i = 0,4 - 1 do
  t[i] = mktoto(i);
    end
    t[0].bar = readint()
    stdinsep()
    t[1].blah = readint()
    local titi = result(t, 4)
    io.write(string.format("%d%d", titi, t[2].blah))
    