<?php

function mktoto($v1){
  $t = array(
    "foo"=>$v1,
    "bar"=>0,
    "blah"=>0
  );
  
  return $t;
}

function result(&$t){
  $t["blah"] = $t["blah"] + 1;
  return $t["foo"] + $t["blah"] * $t["bar"] + $t["bar"] * $t["foo"];
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

$t = mktoto(4);
list($t["bar"]) = scan("%d");
scantrim();
list($t["blah"]) = scan("%d");
$o = result($t);
echo $o;
$p = $t["blah"];
echo $p;
?>
