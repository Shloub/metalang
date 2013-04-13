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

$input = ' ';
$current_pos = 500;
$p = 1000;
$mem = array();
for ($i = 0 ; $i < $p; $i++)
{
  $mem[$i] = 0;
}
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$current_pos = $current_pos + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
$mem[$current_pos] = $mem[$current_pos] + 1;
while ($mem[$current_pos] != 0)
{
  $mem[$current_pos] = $mem[$current_pos] - 1;
  $current_pos = $current_pos - 1;
  $mem[$current_pos] = $mem[$current_pos] + 1;
  $q = $mem[$current_pos];
  echo chr($q);
  $current_pos = $current_pos + 1;
}
?>
