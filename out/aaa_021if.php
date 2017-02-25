<?php
function testA($a, $b) {
    if ($a)
        if ($b)
            echo "A";
        else
            echo "B";
    else if ($b)
        echo "C";
    else
        echo "D";
}
function testB($a, $b) {
    if ($a)
        echo "A";
    else if ($b)
        echo "B";
    else
        echo "C";
}
function testC($a, $b) {
    if ($a)
        if ($b)
            echo "A";
        else
            echo "B";
    else
        echo "C";
}
function testD($a, $b) {
    if ($a)
    {
        if ($b)
            echo "A";
        else
            echo "B";
        echo "C";
    }
    else
        echo "D";
}
function testE($a, $b) {
    if ($a)
    {
        if ($b)
            echo "A";
    }
    else
    {
        if ($b)
            echo "C";
        else
            echo "D";
        echo "E";
    }
}
function test($a, $b) {
    testD($a, $b);
    testE($a, $b);
    echo "\n";
}
test(true, true);
test(true, false);
test(false, true);
test(false, false);

