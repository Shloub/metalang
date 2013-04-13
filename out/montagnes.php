<?php
function montagnes_(&$tab, $len){
  $max_ = 1;
  $j = 1;
  $i = $len - 2;
  while ($i >= 0)
  {
    $x = $tab[$i];
    while (($j >= 0) && ($x > $tab[$len - $j]))
    {
      $j = $j - 1;
    }
    $j = $j + 1;
    $tab[$len - $j] = $x;
    if ($j > $max_)
    {
      $max_ = $j;
    }
    $i = $i - 1;
  }
  return $max_;
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
  $x = 0;
  list($x) = scan("%d");
  scantrim();
  $tab[$i] = $x;
}
$k = montagnes_($tab, $len);
printf("%d", $k);
?>
