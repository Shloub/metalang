<?php

function mktoto($v1){
  $t = array(
    "foo"=>$v1,
    "bar"=>$v1,
    "blah"=>$v1
  );
  
  return $t;
}

function result(&$t_, &$t2_){
  $t = $t_;
  $t2 = $t2_;
  $t3 = array(
    "foo"=>0,
    "bar"=>0,
    "blah"=>0
  );
  
  $t3 = $t2;
  $t = $t2;
  $t2 = $t3;
  $t["blah"] = $t["blah"] + 1;
  $len = 1;
  $cache0 = array();
  for ($i = 0 ; $i <= $len - 1; $i++)
  {
    $cache0[$i] = -$i;
  }
  $cache1 = array();
  for ($i = 0 ; $i <= $len - 1; $i++)
  {
    $cache1[$i] = $i;
  }
  $cache2 = $cache0;
  $cache0 = $cache1;
  $cache2 = $cache0;
  return ($t["foo"] + ($t["blah"] * $t["bar"])) + ($t["bar"] * $t["foo"]);
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
$t2 = mktoto(5);
list($t["bar"]) = scan("%d");
scantrim();
list($t["blah"]) = scan("%d");
scantrim();
list($t2["bar"]) = scan("%d");
scantrim();
list($t["blah"]) = scan("%d");
$q = result($t, $t2);
printf("%d", $q);
$r = $t["blah"];
printf("%d", $r);
?>
