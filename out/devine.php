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
$a = devine_($nombre, $tab, $len);
if ($a)
  echo "True";
else
  echo "False";
?>
