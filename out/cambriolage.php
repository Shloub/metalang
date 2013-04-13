<?php
function max2($a, $b){
  if ($a > $b)
  {
    return $a;
  }
  return $b;
}

function nbPassePartout($n, &$passepartout, $m, &$serrures){
  $max_ancient = 0;
  $max_recent = 0;
  for ($i = 0 ; $i < $m; $i++)
  {
    if (($serrures[$i][0] == -1) && ($serrures[$i][1] > $max_ancient))
    {
      $max_ancient = $serrures[$i][1];
    }
    if (($serrures[$i][0] == 1) && ($serrures[$i][1] > $max_recent))
    {
      $max_recent = $serrures[$i][1];
    }
  }
  $max_ancient_pp = 0;
  $max_recent_pp = 0;
  for ($i = 0 ; $i < $n; $i++)
  {
    $pp = $passepartout[$i];
    if (($pp[0] >= $max_ancient) && ($pp[1] >= $max_recent))
    {
      return 1;
    }
    $max_ancient_pp = max2($max_ancient_pp, $pp[0]);
    $max_recent_pp = max2($max_recent_pp, $pp[1]);
  }
  if (($max_ancient_pp >= $max_ancient) && ($max_recent_pp >= $max_recent))
  {
    return 2;
  }
  else
  {
    return 0;
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

$n = 0;
list($n) = scan("%d");
scantrim();
$passepartout = array();
for ($i = 0 ; $i < $n; $i++)
{
  $bd = 2;
  $out0 = array();
  for ($j = 0 ; $j < $bd; $j++)
  {
    $out_ = 0;
    list($out_) = scan("%d");
    scantrim();
    $out0[$j] = $out_;
  }
  $passepartout[$i] = $out0;
}
$m = 0;
list($m) = scan("%d");
scantrim();
$serrures = array();
for ($i = 0 ; $i < $m; $i++)
{
  $be = 2;
  $out0 = array();
  for ($j = 0 ; $j < $be; $j++)
  {
    $out_ = 0;
    list($out_) = scan("%d");
    scantrim();
    $out0[$j] = $out_;
  }
  $serrures[$i] = $out0;
}
$bf = nbPassePartout($n, $passepartout, $m, $serrures);
echo $bf;
?>
