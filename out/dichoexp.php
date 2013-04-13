<?php
function exp_($a, $b){
  if ($b == 0)
  {
    return 1;
  }
  if (($b % 2) == 0)
  {
    $o = exp_($a, intval($b / 2));
    return $o * $o;
  }
  else
  {
    return $a * exp_($a, $b - 1);
  }
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

$a = 0;
$b = 0;
list($a) = scan("%d");
scantrim();
list($b) = scan("%d");
$j = exp_($a, $b);
echo $j;
?>
