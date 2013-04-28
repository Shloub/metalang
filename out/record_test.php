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
$param = array(
  "foo"=>0,
  "bar"=>0
);

list($param["bar"]) = scan("%d");
scantrim();
list($param["foo"]) = scan("%d");
$h = $param["bar"] + $param["foo"] * $param["bar"];
echo $h;
?>
