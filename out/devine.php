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
function devine0($nombre, &$tab, $len){
  $min0 = $tab[0];
  $max0 = $tab[1];
  for ($i = 2 ; $i < $len; $i++)
  {
    if ($tab[$i] > $max0 || $tab[$i] < $min0)
      return false;
    if ($tab[$i] < $nombre)
      $min0 = $tab[$i];
    if ($tab[$i] > $nombre)
      $max0 = $tab[$i];
    if ($tab[$i] == $nombre && $len != $i + 1)
      return false;
  }
  return true;
}

list($nombre) = scan("%d");
scantrim();
list($len) = scan("%d");
scantrim();
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  list($tmp) = scan("%d");
  scantrim();
  $tab[$i] = $tmp;
}
$a = devine0($nombre, $tab, $len);
if ($a)
  echo "True";
else
  echo "False";
?>
