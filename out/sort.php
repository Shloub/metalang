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
function copytab(&$tab, $len){
  $o = array();
  for ($i = 0 ; $i < $len; $i++)
    $o[$i] = $tab[$i];
  return $o;
}

function bubblesort(&$tab, $len){
  for ($i = 0 ; $i < $len; $i++)
    for ($j = $i + 1 ; $j < $len; $j++)
      if ($tab[$i] > $tab[$j])
  {
    $tmp = $tab[$i];
    $tab[$i] = $tab[$j];
    $tab[$j] = $tmp;
  }
}

function qsort_(&$tab, $len, $i, $j){
  if ($i < $j)
  {
    $i0 = $i;
    $j0 = $j;
    /* pivot : tab[0] */
    while ($i != $j)
      if ($tab[$i] > $tab[$j])
    {
      if ($i == $j - 1)
      {
        /* on inverse simplement*/
        $tmp = $tab[$i];
        $tab[$i] = $tab[$j];
        $tab[$j] = $tmp;
        $i ++;
      }
      else
      {
        /* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] */
        $tmp = $tab[$i];
        $tab[$i] = $tab[$j];
        $tab[$j] = $tab[$i + 1];
        $tab[$i + 1] = $tmp;
        $i ++;
      }
    }
    else
      $j --;
    qsort_($tab, $len, $i0, $i - 1);
    qsort_($tab, $len, $i + 1, $j0);
  }
}

$len = 2;
list($len) = scan("%d");
scantrim();
$tab = array();
for ($i_ = 0 ; $i_ < $len; $i_++)
{
  $tmp = 0;
  list($tmp) = scan("%d");
  scantrim();
  $tab[$i_] = $tmp;
}
$tab2 = copytab($tab, $len);
bubblesort($tab2, $len);
for ($i = 0 ; $i < $len; $i++)
{
  echo $tab2[$i], " ";
}
echo "\n";
$tab3 = copytab($tab, $len);
qsort_($tab3, $len, 0, $len - 1);
for ($i = 0 ; $i < $len; $i++)
{
  echo $tab3[$i], " ";
}
echo "\n";
?>
