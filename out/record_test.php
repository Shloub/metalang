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
