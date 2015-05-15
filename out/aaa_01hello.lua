
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end

io.write("Hello World")
local a = 5
io.write(string.format("%d \n%dfoo", (4 + 6) * 2, a))
local b = 1 + trunc((1 + 1) * 2 * (3 + 8) / 4) - (1 - 2) - 3 == 12 and true
if b
then
  io.write("True")
else
  io.write("False")
end
io.write("\n")
local c = (3 * (4 + 5 + 6) * 2 == 45) == false
if c
then
  io.write("True")
else
  io.write("False")
end
io.write(" ")
local d = (2 == 1) == false
if d
then
  io.write("True")
else
  io.write("False")
end
io.write(string.format(" %d%d", trunc(trunc((4 + 1) / 3) / (2 + 1)), trunc(trunc(4 * 1 / 3) / 2 * 1)))
local e = not(not(a == 0) and not(a == 4))
if e
then
  io.write("True")
else
  io.write("False")
end
local f = true and not(false) and not(true and false)
if f
then
  io.write("True")
else
  io.write("False")
end
io.write("\n")
