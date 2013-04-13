<?php
function sort_(&$tab, $len){
  for ($i = 0 ; $i <= $len - 1; $i++)
  {
    for ($j = $i + 1 ; $j <= $len - 1; $j++)
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

$len = 2;
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
sort_($tab, $len);
for ($r = 0 ; $r <= (count($tab)) - 1; $r++)
{
  printf("%d", $tab[$r]);
}
?>
