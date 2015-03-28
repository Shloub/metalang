var util = require("util");
/*
TODO ajouter un record qui contient des chaines.
*/
function idstring(s){
  return s;
}

function printstring(s){
  util.print(idstring(s), "\n");
}

var tab = new Array(2);
for (var i = 0 ; i <= 2 - 1; i++)
  tab[i] = idstring("chaine de test");
for (var j = 0 ; j <= 1; j++)
  printstring(idstring(tab[j]));

