--[[
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
--]]

local j = 0
j = 0;
io.write(string.format("%d\n", j))
j = 1;
io.write(string.format("%d\n", j))
j = 2;
io.write(string.format("%d\n", j))
j = 3;
io.write(string.format("%d\n", j))
j = 4;
io.write(string.format("%d\n", j))
