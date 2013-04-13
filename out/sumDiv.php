<?php
function sumdiv($n){
  /* On désire renvoyer la somme des diviseurs */
  $out_ = 0;
  /* On déclare un entier qui contiendra la somme */
  for ($i = 1 ; $i <= $n; $i++)
  {
    /* La boucle : i est le diviseur potentiel*/
    if (($n % $i) == 0)
    {
      /* Si i divise */
      $out_ = $out_ + $i;
      /* On incrémente */
    }
    else
    {
      /* nop */
    }
  }
  return $out_;
  /*On renvoie out*/
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
/* Programme principal */
$n = 0;
list($n) = scan("%d");
/* Lecture de l'entier */
$h = sumdiv($n);
printf("%d", $h);
?>
