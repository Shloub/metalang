<?php
$stdin='';
function stdin_(){
  global $stdin;
  if ( !feof(STDIN)) $stdin.=fgets(STDIN)."\n";
}
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
function &mktoto($v1) {
    $t = array(
        "foo" => $v1,
        "bar" => 0,
        "blah" => 0);
    return $t;
}

function result(&$t) {
    $t["blah"]++;
    return $t["foo"] + $t["blah"] * $t["bar"] + $t["bar"] * $t["foo"];
}
$t = mktoto(4);
list($t["bar"]) = scan("%d");
scantrim();
list($t["blah"]) = scan("%d");
echo result($t);

