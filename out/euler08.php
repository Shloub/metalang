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
function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}
$i = 1;
$last = array();
for ($j = 0 ; $j < 5; $j++)
{
  $c = nextChar();
  $d = ord($c) - ord("0");
  $i *= $d;
  $last[$j] = $d;
}
$max_ = $i;
$index = 0;
$nskipdiv = 0;
for ($k = 1 ; $k <= 995; $k++)
{
  $e = nextChar();
  $f = ord($e) - ord("0");
  if ($f == 0)
  {
    $i = 1;
    $nskipdiv = 4;
  }
  else
  {
    $i *= $f;
    if ($nskipdiv < 0)
      $i = intval($i / $last[$index]);
    $nskipdiv --;
  }
  $last[$index] = $f;
  $index = ($index + 1) % 5;
  $max_ = max($max_, $i);
}
echo $max_, "\n";
?>
