<?php
/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
*/
function find0($len, &$tab, &$cache, $x, $y){
  /*
	Cette fonction est récursive
	*/
  if ($y == ($len - 1))
  {
    return $tab[$y][$x];
  }
  else if ($x > $y)
  {
    return 100000;
  }
  else if ($cache[$y][$x] != 0)
  {
    return $cache[$y][$x];
  }
  $result = 0;
  $out0 = find0($len, $tab, $cache, $x, $y + 1);
  $out1 = find0($len, $tab, $cache, $x + 1, $y + 1);
  if ($out0 < $out1)
  {
    $result = $out0 + $tab[$y][$x];
  }
  else
  {
    $result = $out1 + $tab[$y][$x];
  }
  $cache[$y][$y] = $result;
  return $result;
}

function find($len, &$tab){
  $tab2 = array();
  for ($i = 0 ; $i < $len; $i++)
  {
    $bi = $i + 1;
    $tab3 = array();
    for ($j = 0 ; $j < $bi; $j++)
    {
      $tab3[$j] = 0;
    }
    $tab2[$i] = $tab3;
  }
  return find0($len, $tab, $tab2, 0, 0);
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
for ($i = 0 ; $i < $len; $i++)
{
  $bj = $i + 1;
  $tab2 = array();
  for ($j = 0 ; $j < $bj; $j++)
  {
    $tmp = 0;
    list($tmp) = scan("%d");
    scantrim();
    $tab2[$j] = $tmp;
  }
  $tab[$i] = $tab2;
}
$bk = find($len, $tab);
echo $bk;
for ($i = 0 ; $i < $len; $i++)
{
  for ($j = 0 ; $j <= $i; $j++)
  {
    $bl = $tab[$i][$j];
    echo $bl;
  }
  echo "\n";
}
?>
