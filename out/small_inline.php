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
$c = array();
for ($d = 0 ; $d < 2; $d++)
{
  list($c[$d]) = scan("%d");
  scantrim();
}
$t = $c;
echo $t[0], " - ", $t[1], "\n";
?>
