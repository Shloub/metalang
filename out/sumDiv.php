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
function foo(){
  $a = 0;
  /* test */
  $a ++;
  /* test 2 */
}

function foo2(){
  
}

function foo3(){
  if (1 == 1)
  {
    
  }
}

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
      $out_ += $i;
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

/* Programme principal */
$n = 0;
list($n) = scan("%d");
/* Lecture de l'entier */
$j = sumdiv($n);
echo $j;
?>
