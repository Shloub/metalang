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
function nbPassePartout( n, passepartout, m, serrures )
  local max_ancient = 0
  local max_recent = 0
  for i = 0,m - 1 do
    if serrures[i][0] == -1 and serrures[i][1] > max_ancient
    then
      max_ancient = serrures[i][1];
    end
    if serrures[i][0] == 1 and serrures[i][1] > max_recent
    then
      max_recent = serrures[i][1];
    end
  end
  local max_ancient_pp = 0
  local max_recent_pp = 0
  for i = 0,n - 1 do
    local pp = passepartout[i]
    if pp[0] >= max_ancient and pp[1] >= max_recent
    then
      return 1
    end
    max_ancient_pp = math.max(max_ancient_pp, pp[0]);
    max_recent_pp = math.max(max_recent_pp, pp[1]);
  end
  if max_ancient_pp >= max_ancient and max_recent_pp >= max_recent
  then
    return 2
  else
    return 0
  end
end


local n = readint()
stdinsep()
local passepartout = {}
for i = 0,n - 1 do
  local out0 = {}
  for j = 0,2 - 1 do
    local out01 = readint()
    stdinsep()
    out0[j] = out01;
  end
  passepartout[i] = out0;
end
local m = readint()
stdinsep()
local serrures = {}
for k = 0,m - 1 do
  local out1 = {}
  for l = 0,2 - 1 do
    local out_ = readint()
    stdinsep()
    out1[l] = out_;
  end
  serrures[k] = out1;
end
io.write(nbPassePartout(n, passepartout, m, serrures))
