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

$a = 4;
$t = array();
for ($i = 0 ; $i < $a; $i++)
  $t[$i] = mktoto($i);
list($t[0]["bar"]) = scan("%d");
scantrim();
list($t[1]["blah"]) = scan("%d");
$titi = result($t, 4);
echo $titi, $t[2]["blah"];
?>
