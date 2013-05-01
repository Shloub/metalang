<?php

$stdin='';
function stdin_(){   global $stdin; if ( !feof(STDIN)) $stdin.=fgets(STDIN)."\n";}
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
function go(&$tab, $a, $b){
  $m = intval(($a + $b) / 2);
  if ($a == $m)
    if ($tab[$a] == $m)
    return $b;
  else
    return $a;
  $i = $a;
  $j = $b;
  while ($i < $j)
  {
    $e = $tab[$i];
    if ($e < $m)
      $i = $i + 1;
    else
    {
      $j = $j - 1;
      $tab[$i] = $tab[$j];
      $tab[$j] = $e;
    }
  }
  if ($i < $m)
    return go($tab, $a, $m);
  else
    return go($tab, $m, $b);
}

function plus_petit_(&$tab, $len){
  return go($tab, 0, $len);
}

$len = 0;
list($len) = scan("%d");
scantrim();
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  $tmp = 0;
  list($tmp) = scan("%d");
  scantrim();
  $tab[$i] = $tmp;
}
$o = plus_petit_($tab, $len);
echo $o;
?>
