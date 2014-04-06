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
function nth(&$tab, $tofind, $len){
  $out_ = 0;
  for ($i = 0 ; $i < $len; $i++)
    if ($tab[$i] == $tofind)
    $out_ ++;
  return $out_;
}

$len = 0;
list($len) = scan("%d");
scantrim();
$tofind = "\000";
$tofind = nextChar();
scantrim();
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  $tmp = "\000";
  $tmp = nextChar();
  $tab[$i] = $tmp;
}
$result = nth($tab, $tofind, $len);
echo $result;
?>
