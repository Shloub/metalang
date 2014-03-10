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
function max2($a, $b){
  if ($a > $b)
    return $a;
  return $b;
}

function nbPassePartout($n, &$passepartout, $m, &$serrures){
  $max_ancient = 0;
  $max_recent = 0;
  for ($i = 0 ; $i < $m; $i++)
  {
    if ($serrures[$i][0] == -1 && $serrures[$i][1] > $max_ancient)
      $max_ancient = $serrures[$i][1];
    if ($serrures[$i][0] == 1 && $serrures[$i][1] > $max_recent)
      $max_recent = $serrures[$i][1];
  }
  $max_ancient_pp = 0;
  $max_recent_pp = 0;
  for ($i = 0 ; $i < $n; $i++)
  {
    $pp = $passepartout[$i];
    if ($pp[0] >= $max_ancient && $pp[1] >= $max_recent)
      return 1;
    $max_ancient_pp = max2($max_ancient_pp, $pp[0]);
    $max_recent_pp = max2($max_recent_pp, $pp[1]);
  }
  if ($max_ancient_pp >= $max_ancient && $max_recent_pp >= $max_recent)
    return 2;
  else
    return 0;
}

$n = 0;
list($n) = scan("%d");
scantrim();
$passepartout = array();
for ($i = 0 ; $i < $n; $i++)
{
  $c = 2;
  $out0 = array();
  for ($j = 0 ; $j < $c; $j++)
  {
    $out__ = 0;
    list($out__) = scan("%d");
    scantrim();
    $out0[$j] = $out__;
  }
  $passepartout[$i] = $out0;
}
$m = 0;
list($m) = scan("%d");
scantrim();
$serrures = array();
for ($k = 0 ; $k < $m; $k++)
{
  $d = 2;
  $out1 = array();
  for ($l = 0 ; $l < $d; $l++)
  {
    $out_ = 0;
    list($out_) = scan("%d");
    scantrim();
    $out1[$l] = $out_;
  }
  $serrures[$k] = $out1;
}
$e = nbPassePartout($n, $passepartout, $m, $serrures);
echo $e;
?>
