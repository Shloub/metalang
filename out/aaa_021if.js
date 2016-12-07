var util = require("util");
function testA(a, b){
    if (a)
        if (b)
            util.print("A");
        else
            util.print("B");
    else if (b)
        util.print("C");
    else
        util.print("D");
}

function testB(a, b){
    if (a)
        util.print("A");
    else if (b)
        util.print("B");
    else
        util.print("C");
}

function testC(a, b){
    if (a)
        if (b)
            util.print("A");
        else
            util.print("B");
    else
        util.print("C");
}

function testD(a, b){
    if (a)
    {
        if (b)
            util.print("A");
        else
            util.print("B");
        util.print("C");
    }
    else
        util.print("D");
}

function testE(a, b){
    if (a)
    {
        if (b)
            util.print("A");
    }
    else
    {
        if (b)
            util.print("C");
        else
            util.print("D");
        util.print("E");
    }
}

function test(a, b){
    testD(a, b);
    testE(a, b);
    util.print("\n");
}

test(true, true);
test(true, false);
test(false, true);
test(false, false);

