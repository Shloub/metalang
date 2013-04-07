<?php
function devine_($nombre, &$tab, $len){
  $min_ = $tab[0];
  $max_ = $tab[1];
  for ($i = 2 ; $i <= $len - 1; $i++)
  {
    if (($tab[$i] > $max_) || ($tab[$i] < $min_))
    {
      return false;
    }
    if ($tab[$i] < $nombre)
    {
      $min_ = $tab[$i];
    }
    if ($tab[$i] > $nombre)
    {
      $max_ = $tab[$i];
    }
    if (($tab[$i] == $nombre) && ($len != ($i + 1)))
    {
      return false;
    }
  }
  return true;
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

$nombre = 0;
list($nombre) = scan("%d");
scantrim();
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
$j = devine_($nombre, $tab, $len);
if ($j)
{
  printf("%s", "True");
}
else
{
  printf("%s", "False");
}
?>