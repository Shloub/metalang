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
  $t_ = array(
    "foo"=>$v1,
    "bar"=>0,
    "blah"=>0
  );
  
  return $t_;
}

function result(&$t_){
  $t_["blah"] ++;
  return $t_["foo"] + $t_["blah"] * $t_["bar"] + $t_["bar"] * $t_["foo"];
}

$t_ = mktoto(4);
list($t_["bar"]) = scan("%d");
scantrim();
list($t_["blah"]) = scan("%d");
$a = result($t_);
echo $a;
$b = $t_["blah"];
echo $b;
?>
