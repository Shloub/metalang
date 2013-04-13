<?php
function nth(&$tab, $tofind, $len){
  $out_ = 0;
  for ($i = 0 ; $i < $len; $i++)
  {
    if ($tab[$i] == $tofind)
    {
      $out_ = $out_ + 1;
    }
  }
  return $out_;
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
$tofind = '\000';
$tofind = nextChar();
scantrim();
$tab = array();
for ($i = 0 ; $i < $len; $i++)
{
  $tmp = '\000';
  $tmp = nextChar();
  $tab[$i] = $tmp;
}
$result = nth($tab, $tofind, $len);
echo $result;
?>
