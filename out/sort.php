<?php

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
function sort_(&$tab, $len){
  for ($i = 0 ; $i < $len; $i++)
  {
    for ($j = $i + 1 ; $j < $len; $j++)
    {
      if ($tab[$i] > $tab[$j])
      {
        $tmp = $tab[$i];
        $tab[$i] = $tab[$j];
        $tab[$j] = $tmp;
      }
    }
  }
}

$len = 2;
list($len) = scan("%d");
scantrim();
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  $tmp = 0;
  list($tmp) = scan("%d");
  scantrim();
  $tab[$i] = $tmp;
}
sort_($tab, $len);
for ($i = 0 ; $i < $len; $i++)
{
  $k = $tab[$i];
  echo $k;
}
?>
