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
}/*
La suite de fibonaci
*/
function fibo_($a, $b, $i){
  $out_ = 0;
  $a2 = $a;
  $b2 = $b;
  for ($j = 0 ; $j <= $i + 1; $j++)
  {
    $out_ = $out_ + $a2;
    $tmp = $b2;
    $b2 = $b2 + $a2;
    $a2 = $tmp;
  }
  return $out_;
}

$a = 0;
$b = 0;
$i = 0;
list($a) = scan("%d");
scantrim();
list($b) = scan("%d");
scantrim();
list($i) = scan("%d");
$l = fibo_($a, $b, $i);
echo $l;
?>
