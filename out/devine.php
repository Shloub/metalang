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
function devine_($nombre, &$tab, $len){
  $min_ = $tab[0];
  $max_ = $tab[1];
  for ($i = 2 ; $i < $len; $i++)
  {
    echo $i, " => ";
    $a = $tab[$i];
    echo $a, "\n";
    if ($tab[$i] > $max_ || $tab[$i] < $min_)
      return false;
    if ($tab[$i] < $nombre)
      $min_ = $tab[$i];
    if ($tab[$i] > $nombre)
      $max_ = $tab[$i];
    if ($tab[$i] == $nombre && $len != $i + 1)
      return false;
  }
  return true;
}

$nombre = 0;
list($nombre) = scan("%d");
scantrim();
$len = 0;
list($len) = scan("%d");
scantrim();
echo $nombre, " ", $len, "\n";
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  $tmp = 0;
  list($tmp) = scan("%d");
  scantrim();
  echo $tmp, " ";
  $tab[$i] = $tmp;
}
echo "\n";
$b = devine_($nombre, $tab, $len);
if ($b)
  echo "True";
else
  echo "False";
?>
