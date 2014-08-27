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
}/*
Ce test effectue un rot13 sur une chaine lue en entrée
*/
list($strlen) = scan("%d");
scantrim();
$tab4 = array();
for ($toto = 0 ; $toto < $strlen; $toto++)
{
  $tmpc = nextChar();
  $c = ord($tmpc);
  if ($tmpc != " ")
    $c = (($c - ord("a")) + 13) % 26 + ord("a");
  $tab4[$toto] = chr($c);
}
for ($j = 0 ; $j < $strlen; $j++)
  echo $tab4[$j];
?>
