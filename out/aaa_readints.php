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
function read_int_line($n){
  $tab = array();
  for ($i = 0 ; $i < $n; $i++)
  {
    $t = 0;
    list($t) = scan("%d");
    scantrim();
    $tab[$i] = $t;
  }
  return $tab;
}

$l0 = read_int_line(1);
$len = $l0[0];
echo $len;
echo "=len\n";
$tab1 = read_int_line($len);
for ($i = 0 ; $i < $len; $i++)
{
  echo $i;
  echo "=>";
  $a = $tab1[$i];
  echo $a;
  echo "\n";
}
$tab2 = read_int_line($len);
for ($i = 0 ; $i < $len; $i++)
{
  echo $i;
  echo "=>";
  $b = $tab2[$i];
  echo $b;
  echo "\n";
}
?>
