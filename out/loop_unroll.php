<?php


$stdin='';
while (!feof(STDIN)) $stdin.=fgets(STDIN);
function scan($format){
  global $stdin;
  $out = sscanf($stdin, $format);
  $stdin = substr($stdin, strlen($out[0]));
  return $out;
}
function scantrim(){
  global $stdin;
  $stdin = trim($stdin);
}
function nextChar(){
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}

$j = 0;
$j = 0;
echo $j;
echo "\n";
$j = 1;
echo $j;
echo "\n";
$j = 2;
echo $j;
echo "\n";
$j = 3;
echo $j;
echo "\n";
$j = 4;
echo $j;
echo "\n";
?>
