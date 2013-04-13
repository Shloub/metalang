<?php

function is_number($c){
  return ($c <= '9') && ($c >= '0');
}

/*
Notation polonaise inversée
*/
function npi_(&$str, $len){
  $stack = array();
  for ($i = 0 ; $i < $len; $i++)
  {
    $stack[$i] = 0;
  }
  $ptrStack = 0;
  $ptrStr = 0;
  while ($ptrStr < $len)
  {
    if ($str[$ptrStr] == ' ')
    {
      $ptrStr = $ptrStr + 1;
    }
    else if (is_number($str[$ptrStr]))
    {
      $num = 0;
      while ($str[$ptrStr] != ' ')
      {
        $num = $num * 10 + $str[$ptrStr] - '0';
        $ptrStr = $ptrStr + 1;
      }
      $stack[$ptrStack] = $num;
      $ptrStack = $ptrStack + 1;
    }
    else if ($str[$ptrStr] == '+')
    {
      $stack[$ptrStack - 2] = $stack[$ptrStack - 2] + $stack[$ptrStack - 1];
      $ptrStack = $ptrStack - 1;
      $ptrStr = $ptrStr + 1;
    }
  }
  return $stack[0];
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

$len = 0;
list($len) = scan("%d");
scantrim();
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  $tmp = '\000';
  $tmp = nextChar();
  $tab[$i] = $tmp;
}
$result = npi_($tab, $len);
echo $result;
?>
