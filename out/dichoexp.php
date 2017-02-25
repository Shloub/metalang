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
function exp0($a, $b) {
    if ($b == 0)
        return 1;
    if ($b % 2 == 0)
    {
        $o = exp0($a, intval($b / 2));
        return $o * $o;
    }
    else
        return $a * exp0($a, $b - 1);
}
$a = 0;
$b = 0;
list($a) = scan("%d");
scantrim();
list($b) = scan("%d");
echo exp0($a, $b);

