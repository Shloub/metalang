<?php
$stdin='';
function stdin_(){
  global $stdin;
  if ( !feof(STDIN)) $stdin.=fgets(STDIN)."\n";
}
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
function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}
/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
list($len) = scan("%d");
scantrim();
echo $len, "=len\n";
$len *= 2;
echo "len*2=", $len, "\n";
$len = intval($len / 2);
$tab = array();
for ($i = 0; $i < $len; $i += 1)
{
    list($tmpi1) = scan("%d");
    scantrim();
    echo $i, "=>", $tmpi1, " ";
    $tab[$i] = $tmpi1;
}
echo "\n";
$tab2 = array();
for ($i_ = 0; $i_ < $len; $i_ += 1)
{
    list($tmpi2) = scan("%d");
    scantrim();
    echo $i_, "==>", $tmpi2, " ";
    $tab2[$i_] = $tmpi2;
}
list($strlen) = scan("%d");
scantrim();
echo $strlen, "=strlen\n";
$tab4 = array();
for ($toto = 0; $toto < $strlen; $toto += 1)
{
    $tmpc = nextChar();
    $c = ord($tmpc);
    echo $tmpc, ":", $c, " ";
    if ($tmpc != " ")
        $c = ($c - ord("a") + 13) % 26 + ord("a");
    $tab4[$toto] = chr($c);
}
for ($j = 0; $j < $strlen; $j += 1)
    echo $tab4[$j];

