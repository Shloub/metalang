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
function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}
function isqrt($c){
  return intval(sqrt($c));
}

function is_triangular($n){
  /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
  $d = $n * 2;
  $b = intval(sqrt($d));
  $a = $b;
  return $a * ($a + 1) == $n * 2;
}

function score(){
  scantrim();
  $len = 0;
  list($len) = scan("%d");
  scantrim();
  $sum = 0;
  for ($i = 1 ; $i <= $len; $i++)
  {
    $c = "_";
    $c = nextChar();
    $sum += (ord($c) - ord("A")) + 1;
    /*		print c print " " print sum print " " */
  }
  if (is_triangular($sum))
    return 1;
  else
    return 0;
}

for ($i = 1 ; $i <= 55; $i++)
  if (is_triangular($i))
{
  echo $i, " ";
}
echo "\n";
$sum = 0;
$n = 0;
list($n) = scan("%d");
for ($i = 1 ; $i <= $n; $i++)
  $sum += score();
echo $sum, "\n";
?>
