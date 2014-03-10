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

function result(&$t_, $len){
  $out_ = 0;
  for ($j = 0 ; $j < $len; $j++)
  {
    $t_[$j]["blah"] = $t_[$j]["blah"] + 1;
    $out_ = $out_ + $t_[$j]["foo"] + $t_[$j]["blah"] * $t_[$j]["bar"] + $t_[$j]["bar"] * $t_[$j]["foo"];
  }
  return $out_;
}

$a = 4;
$t_ = array();
for ($i = 0 ; $i < $a; $i++)
  $t_[$i] = mktoto($i);
list($t_[0]["bar"]) = scan("%d");
scantrim();
list($t_[1]["blah"]) = scan("%d");
$b = result($t_, 4);
echo $b;
$c = $t_[2]["blah"];
echo $c;
?>
