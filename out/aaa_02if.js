var util = require("util");
function f(i){
    if (i == 0)
        return true;
    return false;
}
if (f(4))
    util.print("true <-\n ->\n");
else
    util.print("false <-\n ->\n");
util.print("small test end\n");

