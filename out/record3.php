<?php

function mktoto($v1){
  $t = array(
    "foo"=>$v1,
    "bar"=>0,
    "blah"=>0
  );
  
  return $t;
}

function result(&$t, $len){
  $out_ = 0;
  for ($j = 0 ; $j < $len; $j++)
  {
    $t[$j]["blah"] = $t[$j]["blah"] + 1;
    $out_ = $out_ + $t[$j]["foo"] + $t[$j]["blah"] * $t[$j]["bar"] + $t[$j]["bar"] * $t[$j]["foo"];
  }
  return $out_;
}


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

$z = 4;
$t = array();
for ($i = 0 ; $i < $z; $i++)
{
  $t[$i] = mktoto($i);
}
list($t[0]["bar"]) = scan("%d");
scantrim();
list($t[1]["blah"]) = scan("%d");
$ba = result($t, 4);
echo $ba;
$bb = $t[2]["blah"];
echo $bb;
?>
