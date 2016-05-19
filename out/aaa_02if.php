<?php

function f($i) {
    if ($i == 0)
      return true;
    return false;
}

if (f(4))
  echo "true <-\n ->\n";
else
  echo "false <-\n ->\n";
echo "small test end\n";

