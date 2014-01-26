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

function read_int_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
  {
    $out_ = read_int_line($x);
    scantrim();
    $tab[$z] = $out_;
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
$l0 = read_int_line(1);
$len = $l0[0];
$tab2 = read_int_matrix($len, $len - 1);
for ($i = 0 ; $i <= $len - 2; $i++)
{
  for ($j = 0 ; $j < $len; $j++)
  {
    $b = $tab2[$i][$j];
    echo $b;
    echo " ";
  }
  echo "\n";
}
?>
