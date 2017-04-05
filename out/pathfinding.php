<?php
$stdin='';
function stdin_(){
  global $stdin;
  if ( !feof(STDIN)) $stdin.=fgets(STDIN)."\n";
}
function scan($format){
  stdin_();
  global $stdin;
  $out = sscanf($stdin, $format);
  $stdin = substr($stdin, strlen($out[0]));
  return $out;
}
function scantrim(){
  global $stdin;
  while(true){
    $stdin = ltrim($stdin);
    if ($stdin != '' || feof(STDIN)) break;
    stdin_();
  }
}
function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}
function pathfind_aux(&$cache, &$tab, $x, $y, $posX, $posY) {
    if ($posX == $x - 1 && $posY == $y - 1)
        return 0;
    else if ($posX < 0 || $posY < 0 || $posX >= $x || $posY >= $y)
        return $x * $y * 10;
    else if ($tab[$posY][$posX] == "#")
        return $x * $y * 10;
    else if ($cache[$posY][$posX] != -1)
        return $cache[$posY][$posX];
    else
    {
        $cache[$posY][$posX] = $x * $y * 10;
        $val1 = pathfind_aux($cache, $tab, $x, $y, $posX + 1, $posY);
        $val2 = pathfind_aux($cache, $tab, $x, $y, $posX - 1, $posY);
        $val3 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY - 1);
        $val4 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY + 1);
        $out0 = 1 + min($val1, $val2, $val3, $val4);
        $cache[$posY][$posX] = $out0;
        return $out0;
    }
}

function pathfind(&$tab, $x, $y) {
    $cache = array();
    for ($i = 0; $i < $y; $i++)
    {
        $tmp = array();
        for ($j = 0; $j < $x; $j++)
            $tmp[$j] = -1;
        $cache[$i] = $tmp;
    }
    return pathfind_aux($cache, $tab, $x, $y, 0, 0);
}
list($x) = scan("%d");
scantrim();
list($y) = scan("%d");
scantrim();
$tab = array();
for ($i = 0; $i < $y; $i++)
{
    $tab2 = array();
    for ($j = 0; $j < $x; $j++)
    {
        $tmp = "\x00";
        $tmp = nextChar();
        $tab2[$j] = $tmp;
    }
    scantrim();
    $tab[$i] = $tab2;
}
$result = pathfind($tab, $x, $y);
echo $result;

