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
function position_alphabet($c) {
    $i = ord($c);
    if ($i <= ord("Z") && $i >= ord("A"))
        return $i - ord("A");
    else if ($i <= ord("z") && $i >= ord("a"))
        return $i - ord("a");
    else
        return -1;
}

function of_position_alphabet($c) {
    return chr($c + ord("a"));
}

function crypte($taille_cle, &$cle, $taille, &$message) {
    for ($i = 0; $i < $taille; $i++)
    {
        $lettre = position_alphabet($message[$i]);
        if ($lettre != -1)
        {
            $addon = position_alphabet($cle[$i % $taille_cle]);
            $new0 = ($addon + $lettre) % 26;
            $message[$i] = of_position_alphabet($new0);
        }
    }
}

list($taille_cle) = scan("%d");
scantrim();
$cle = array();
for ($index = 0; $index < $taille_cle; $index++)
{
    $out0 = nextChar();
    $cle[$index] = $out0;
}
scantrim();
list($taille) = scan("%d");
scantrim();
$message = array();
for ($index2 = 0; $index2 < $taille; $index2++)
{
    $out2 = nextChar();
    $message[$index2] = $out2;
}
crypte($taille_cle, $cle, $taille, $message);
for ($i = 0; $i < $taille; $i++)
    echo $message[$i];
echo "\n";

