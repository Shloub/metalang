
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end

io.write("Hello World")
local a = 5
io.write(string.format("%d \n%dfoo", (4 + 6) * 2, a))
if 1 + trunc(2 * 2 * (3 + 8) / 4) - 2 == 12 and true then
    io.write("True")
else 
    io.write("False")
end
io.write("\n")
if (3 * (4 + 11) * 2 == 45) == false then
    io.write("True")
else 
    io.write("False")
end
io.write(" ")
if (2 == 1) == false then
    io.write("True")
else 
    io.write("False")
end
io.write(string.format(" %d%d", trunc(trunc(5 / 3) / 3), trunc(trunc(4 * 1 / 3) / 2 * 1)))
if not(not(a == 0) and not(a == 4)) then
    io.write("True")
else 
    io.write("False")
end
if true and not(false) and not(true and false) then
    io.write("True")
else 
    io.write("False")
end
io.write("\n")
