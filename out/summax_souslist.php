<?php
function summax(&$lst, $len){
  $current = 0;
  $max_ = 0;
  for ($i = 0 ; $i <= $len - 1; $i++)
  {
    $current = $current + $lst[$i];
    if ($current < 0)
    {
      $current = 0;
    }
    if ($max_ < $current)
    {
      $max_ = $current;
    }
  }
  return $max_;
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
for ($i = 0 ; $i <= $len - 1; $i++)
{
  $tmp = 0;
  list($tmp) = scan("%d");
  scantrim();
  $tab[$i] = $tmp;
}
$result = summax($tab, $len);
printf("%d", $result);
?>
