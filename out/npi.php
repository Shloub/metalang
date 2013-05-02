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
function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return ord($out);
}
function is_number($c){
  return $c <= ord('9') && $c >= ord('0');
}

/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
function npi_(&$str, $len){
  $stack = array();
  for ($i = 0 ; $i < $len; $i++)
    $stack[$i] = 0;
  $ptrStack = 0;
  $ptrStr = 0;
  while ($ptrStr < $len)
    if ($str[$ptrStr] == ord(' '))
    $ptrStr ++;
  else if (is_number($str[$ptrStr]))
  {
    $num = 0;
    while ($str[$ptrStr] != ord(' '))
    {
      $num = $num * 10 + $str[$ptrStr] - ord('0');
      $ptrStr ++;
    }
    $stack[$ptrStack] = $num;
    $ptrStack ++;
  }
  else if ($str[$ptrStr] == ord('+'))
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
  $tmp = ord('\000');
  $tmp = nextChar();
  $tab[$i] = $tmp;
}
$result = npi_($tab, $len);
echo $result;
?>
