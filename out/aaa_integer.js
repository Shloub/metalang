var util = require("util");
var i = 0;
i -= 1;
util.print(i, "\n");
i += 55;
util.print(i, "\n");
i *= 13;
util.print(i, "\n");
i = ~~(i / 2);
util.print(i, "\n");
i += 1;
util.print(i, "\n");
i = ~~(i / 3);
util.print(i, "\n");
i -= 1;
util.print(i, "\n");
/*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
util.print(~~(117 / 17), "\n", ~~(117 / -17), "\n", ~~(-117 / 17), "\n", ~~(-117 / -17), "\n", ~~(117 % 17), "\n", ~~(117 % -17), "\n", ~~(-117 % 17), "\n", ~~(-117 % -17), "\n");

