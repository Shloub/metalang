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
function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}
function score() {
    scantrim();
    list($len) = scan("%d");
    scantrim();
    $sum = 0;
    for ($i = 1; $i <= $len; $i++)
    {
        $c = nextChar();
        $sum += ord($c) - ord("A") + 1;
        // 		print c print " " print sum print " " 
    }
    return $sum;
}

$sum = 0;
list($n) = scan("%d");
for ($i = 1; $i <= $n; $i++)
    $sum += $i * score();
echo $sum, "\n";

