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
function summax(&$lst, $len){
  $current = 0;
  $max_ = 0;
  for ($i = 0 ; $i < $len; $i++)
  {
    $current += $lst[$i];
    if ($current < 0)
      $current = 0;
    if ($max_ < $current)
      $max_ = $current;
  }
  return $max_;
}

$len = 0;
list($len) = scan("%d");
scantrim();
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  $tmp = 0;
  list($tmp) = scan("%d");
  scantrim();
  $tab[$i] = $tmp;
}
$result = summax($tab, $len);
echo $result;
?>
