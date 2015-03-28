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
function is_number($c){
  return ord($c) <= ord("9") && ord($c) >= ord("0");
}

/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
function npi0(&$str, $len){
  $stack = array();
  for ($i = 0 ; $i < $len; $i++)
    $stack[$i] = 0;
  $ptrStack = 0;
  $ptrStr = 0;
  while ($ptrStr < $len)
    if ($str[$ptrStr] == " ")
    $ptrStr ++;
  else if (is_number($str[$ptrStr]))
  {
    $num = 0;
    while ($str[$ptrStr] != " ")
    {
      $num = $num * 10 + ord($str[$ptrStr]) - ord("0");
      $ptrStr ++;
    }
    $stack[$ptrStack] = $num;
    $ptrStack ++;
  }
  else if ($str[$ptrStr] == "+")
  {
    $stack[$ptrStack - 2] = $stack[$ptrStack - 2] + $stack[$ptrStack - 1];
    $ptrStack --;
    $ptrStr ++;
  }
  return $stack[0];
}

$len = 0;
list($len) = scan("%d");
scantrim();
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  $tmp = "\x00";
  $tmp = nextChar();
  $tab[$i] = $tmp;
}
$result = npi0($tab, $len);
echo $result;
?>
