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
/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
*/

function find0($len, &$tab, &$cache, $x, $y) {
    /*
	Cette fonction est récursive
	*/
    if ($y == $len - 1)
        return $tab[$y][$x];
    else if ($x > $y)
        return -10000;
    else if ($cache[$y][$x] != 0)
        return $cache[$y][$x];
    $result = 0;
    $out0 = find0($len, $tab, $cache, $x, $y + 1);
    $out1 = find0($len, $tab, $cache, $x + 1, $y + 1);
    if ($out0 > $out1)
        $result = $out0 + $tab[$y][$x];
    else
        $result = $out1 + $tab[$y][$x];
    $cache[$y][$x] = $result;
    return $result;
}

function find($len, &$tab) {
    $tab2 = array();
    for ($i = 0; $i < $len; $i++)
    {
        $tab3 = array_fill(0, $i + 1, 0);
        $tab2[$i] = $tab3;
    }
    return find0($len, $tab, $tab2, 0, 0);
}
$len = 0;
list($len) = scan("%d");
scantrim();
$tab = array();
for ($i = 0; $i < $len; $i++)
{
    $tab2 = array();
    for ($j = 0; $j <= $i; $j++)
    {
        $tmp = 0;
        list($tmp) = scan("%d");
        scantrim();
        $tab2[$j] = $tmp;
    }
    $tab[$i] = $tab2;
}
echo find($len, $tab), "\n";
for ($k = 0; $k < $len; $k++)
{
    for ($l = 0; $l <= $k; $l++)
        echo $tab[$k][$l], " ";
    echo "\n";
}

