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
}/*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/

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
  $t["blah"] ++;
  $len = 1;
  $cache0 = array();
  for ($i = 0 ; $i < $len; $i++)
    $cache0[$i] = -$i;
  $cache1 = array();
  for ($i = 0 ; $i < $len; $i++)
    $cache1[$i] = $i;
  $cache2 = $cache0;
  $cache0 = $cache1;
  $cache2 = $cache0;
  return $t["foo"] + $t["blah"] * $t["bar"] + $t["bar"] * $t["foo"];
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
echo $q;
$r = $t["blah"];
echo $r;
?>
