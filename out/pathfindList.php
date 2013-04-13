<?php
function pathfind_aux(&$cache, &$tab, $len, $pos){
  if ($pos >= ($len - 1))
  {
    return 0;
  }
  else if ($cache[$pos] != (-1))
  {
    return $cache[$pos];
  }
  else
  {
    $cache[$pos] = $len * 2;
    $posval = pathfind_aux($cache, $tab, $len, $tab[$pos]);
    $oneval = pathfind_aux($cache, $tab, $len, $pos + 1);
    $out_ = 0;
    if ($posval < $oneval)
    {
      $out_ = 1 + $posval;
    }
    else
    {
      $out_ = 1 + $oneval;
    }
    $cache[$pos] = $out_;
    return $out_;
  }
}

function pathfind(&$tab, $len){
  $cache = array();
  for ($i = 0 ; $i <= $len - 1; $i++)
  {
    $cache[$i] = -1;
  }
  return pathfind_aux($cache, $tab, $len, 0);
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
for ($i = 0 ; $i <= $len - 1; $i++)
{
  $tmp = 0;
  list($tmp) = scan("%d");
  scantrim();
  $tab[$i] = $tmp;
}
$result = pathfind($tab, $len);
printf("%d", $result);
?>
