<?php
function min4($a, $b, $c, $d){
  return min($a, $b, $c, $d);
}

function read_int(){
  return intval(trim(fgets(STDIN)));
}

function read_char_line($n){
  return fgets(STDIN);
}

function read_char_matrix($x, $y){
  $tab = array();
  for ($z = 0 ; $z < $y; $z++)
    $tab[$z] = read_char_line($x);
  return $tab;
}

function pathfind_aux(&$cache, &$tab, $x, $y, $posX, $posY){
  if ($posX == $x - 1 && $posY == $y - 1)
    return 0;
  else if ($posX < 0 || $posY < 0 || $posX >= $x || $posY >= $y)
    return $x * $y * 10;
  else if ($tab[$posY][$posX] == "#")
    return $x * $y * 10;
  else if ($cache[$posY][$posX] != -1)
    return $cache[$posY][$posX];
  else
  {
    $cache[$posY][$posX] = $x * $y * 10;
    $val1 = pathfind_aux($cache, $tab, $x, $y, $posX + 1, $posY);
    $val2 = pathfind_aux($cache, $tab, $x, $y, $posX - 1, $posY);
    $val3 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY - 1);
    $val4 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY + 1);
    $out_ = 1 + min4($val1, $val2, $val3, $val4);
    $cache[$posY][$posX] = $out_;
    return $out_;
  }
}

function pathfind(&$tab, $x, $y){
  $cache = array();
  for ($i = 0 ; $i < $y; $i++)
  {
    $tmp = array();
    for ($j = 0 ; $j < $x; $j++)
    {
      $e = $tab[$i][$j];
      echo $e;
      $tmp[$j] = -1;
    }
    echo "\n";
    $cache[$i] = $tmp;
  }
  return pathfind_aux($cache, $tab, $x, $y, 0, 0);
}

$x = read_int();
$y = read_int();
echo $x, " ", $y, "\n";
$tab = read_char_matrix($x, $y);
$result = pathfind($tab, $x, $y);
echo $result;
?>
