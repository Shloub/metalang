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
function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}
function &read_bigint($len){
  $chiffres = array();
  for ($j = 0 ; $j < $len; $j++)
  {
    $c = nextChar();
    $chiffres[$j] = ord($c);
  }
  for ($i = 0 ; $i <= intval(($len - 1) / 2); $i++)
  {
    $tmp = $chiffres[$i];
    $chiffres[$i] = $chiffres[$len - 1 - $i];
    $chiffres[$len - 1 - $i] = $tmp;
  }
  $e = array(
    "bigint_sign"=>true,
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  return $e;
}

function print_bigint(&$a){
  if (!$a["bigint_sign"])
    echo "-";
  for ($i = 0 ; $i < $a["bigint_len"]; $i++)
    echo $a["bigint_chiffres"][$a["bigint_len"] - 1 - $i];
}

function bigint_eq(&$a, &$b){
  /* Renvoie vrai si a = b */
  if ($a["bigint_sign"] != $b["bigint_sign"])
    return false;
  else if ($a["bigint_len"] != $b["bigint_len"])
    return false;
  else
  {
    for ($i = 0 ; $i < $a["bigint_len"]; $i++)
      if ($a["bigint_chiffres"][$i] != $b["bigint_chiffres"][$i])
      return false;
    return true;
  }
}

function bigint_gt(&$a, &$b){
  /* Renvoie vrai si a > b */
  if ($a["bigint_sign"] && !$b["bigint_sign"])
    return true;
  else if (!$a["bigint_sign"] && $b["bigint_sign"])
    return false;
  else
  {
    if ($a["bigint_len"] > $b["bigint_len"])
      return $a["bigint_sign"];
    else if ($a["bigint_len"] < $b["bigint_len"])
      return !$a["bigint_sign"];
    else
      for ($i = 0 ; $i < $a["bigint_len"]; $i++)
      {
        $j = $a["bigint_len"] - 1 - $i;
        if ($a["bigint_chiffres"][$j] > $b["bigint_chiffres"][$j])
          return $a["bigint_sign"];
        else if ($a["bigint_chiffres"][$j] < $b["bigint_chiffres"][$j])
          return !$a["bigint_sign"];
    }
    return true;
  }
}

function bigint_lt(&$a, &$b){
  return !bigint_gt($a, $b);
}

function &add_bigint_positif(&$a, &$b){
  /* Une addition ou on en a rien a faire des signes */
  $len = max($a["bigint_len"], $b["bigint_len"]) + 1;
  $retenue = 0;
  $chiffres = array();
  for ($i = 0 ; $i < $len; $i++)
  {
    $tmp = $retenue;
    if ($i < $a["bigint_len"])
      $tmp += $a["bigint_chiffres"][$i];
    if ($i < $b["bigint_len"])
      $tmp += $b["bigint_chiffres"][$i];
    $retenue = intval($tmp / 10);
    $chiffres[$i] = $tmp % 10;
  }
  while ($len > 0 && $chiffres[$len - 1] == 0)
    $len --;
  $f = array(
    "bigint_sign"=>true,
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  return $f;
}

function &sub_bigint_positif(&$a, &$b){
  /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
  $len = $a["bigint_len"];
  $retenue = 0;
  $chiffres = array();
  for ($i = 0 ; $i < $len; $i++)
  {
    $tmp = $retenue + $a["bigint_chiffres"][$i];
    if ($i < $b["bigint_len"])
      $tmp -= $b["bigint_chiffres"][$i];
    if ($tmp < 0)
    {
      $tmp += 10;
      $retenue = -1;
    }
    else
      $retenue = 0;
    $chiffres[$i] = $tmp;
  }
  while ($len > 0 && $chiffres[$len - 1] == 0)
    $len --;
  $g = array(
    "bigint_sign"=>true,
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  return $g;
}

function &neg_bigint(&$a){
  $h = array(
    "bigint_sign"=>!$a["bigint_sign"],
    "bigint_len"=>$a["bigint_len"],
    "bigint_chiffres"=>$a["bigint_chiffres"]
  );
  
  return $h;
}

function &add_bigint(&$a, &$b){
  if ($a["bigint_sign"] == $b["bigint_sign"])
  {
    if ($a["bigint_sign"])
      return add_bigint_positif($a, $b);
    else
      return neg_bigint(add_bigint_positif($a, $b));
  }
  else if ($a["bigint_sign"])
  {
    /* a positif, b negatif */
    if (bigint_gt($a, neg_bigint($b)))
      return sub_bigint_positif($a, $b);
    else
      return neg_bigint(sub_bigint_positif($b, $a));
  }
  else
  {
    /* a negatif, b positif */
    if (bigint_gt(neg_bigint($a), $b))
      return neg_bigint(sub_bigint_positif($a, $b));
    else
      return sub_bigint_positif($b, $a);
  }
}

function &sub_bigint(&$a, &$b){
  return add_bigint($a, neg_bigint($b));
}

function &mul_bigint_cp(&$a, &$b){
  /* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. */
  $len = $a["bigint_len"] + $b["bigint_len"] + 1;
  $chiffres = array();
  for ($k = 0 ; $k < $len; $k++)
    $chiffres[$k] = 0;
  for ($i = 0 ; $i < $a["bigint_len"]; $i++)
  {
    $retenue = 0;
    for ($j = 0 ; $j < $b["bigint_len"]; $j++)
    {
      $chiffres[$i + $j] = $chiffres[$i + $j] + $retenue +
      $b["bigint_chiffres"][$j] * $a["bigint_chiffres"][$i];
      $retenue = intval($chiffres[$i + $j] / 10);
      $chiffres[$i + $j] = $chiffres[$i + $j] % 10;
    }
    $chiffres[$i + $b["bigint_len"]] = $chiffres[$i + $b["bigint_len"]] +
    $retenue;
  }
  $chiffres[$a["bigint_len"] + $b["bigint_len"]] =
  intval($chiffres[$a["bigint_len"] + $b["bigint_len"] - 1] / 10);
  $chiffres[$a["bigint_len"] + $b["bigint_len"] - 1] =
  $chiffres[$a["bigint_len"] + $b["bigint_len"] - 1] % 10;
  for ($l = 0 ; $l <= 2; $l++)
    if ($len != 0 && $chiffres[$len - 1] == 0)
    $len --;
  $m = array(
    "bigint_sign"=>$a["bigint_sign"] == $b["bigint_sign"],
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  return $m;
}

function &bigint_premiers_chiffres(&$a, $i){
  $len = min($i, $a["bigint_len"]);
  while ($len != 0 && $a["bigint_chiffres"][$len - 1] == 0)
    $len --;
  $o = array(
    "bigint_sign"=>$a["bigint_sign"],
    "bigint_len"=>$len,
    "bigint_chiffres"=>$a["bigint_chiffres"]
  );
  
  return $o;
}

function &bigint_shift(&$a, $i){
  $chiffres = array();
  for ($k = 0 ; $k < $a["bigint_len"] + $i; $k++)
    if ($k >= $i)
    $chiffres[$k] = $a["bigint_chiffres"][$k - $i];
  else
    $chiffres[$k] = 0;
  $p = array(
    "bigint_sign"=>$a["bigint_sign"],
    "bigint_len"=>$a["bigint_len"] + $i,
    "bigint_chiffres"=>$chiffres
  );
  
  return $p;
}

function &mul_bigint(&$aa, &$bb){
  if ($aa["bigint_len"] == 0)
    return $aa;
  else if ($bb["bigint_len"] == 0)
    return $bb;
  else if ($aa["bigint_len"] < 3 || $bb["bigint_len"] < 3)
    return mul_bigint_cp($aa, $bb);
  /* Algorithme de Karatsuba */
  $split = intval(min($aa["bigint_len"], $bb["bigint_len"]) / 2);
  $a = bigint_shift($aa, -$split);
  $b = bigint_premiers_chiffres($aa, $split);
  $c = bigint_shift($bb, -$split);
  $d = bigint_premiers_chiffres($bb, $split);
  $amoinsb = sub_bigint($a, $b);
  $cmoinsd = sub_bigint($c, $d);
  $ac = mul_bigint($a, $c);
  $bd = mul_bigint($b, $d);
  $amoinsbcmoinsd = mul_bigint($amoinsb, $cmoinsd);
  $acdec = bigint_shift($ac, 2 * $split);
  return add_bigint(add_bigint($acdec, $bd), bigint_shift(sub_bigint(add_bigint($ac, $bd), $amoinsbcmoinsd), $split));
  /* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd */
}

/*
Division,
Modulo
*/
function log100($a){
  $out0 = 1;
  while ($a >= 10)
  {
    $a = intval($a / 10);
    $out0 ++;
  }
  return $out0;
}

function &bigint_of_int($i){
  $size = log100($i);
  if ($i == 0)
    $size = 0;
  $t = array();
  for ($j = 0 ; $j < $size; $j++)
    $t[$j] = 0;
  for ($k = 0 ; $k < $size; $k++)
  {
    $t[$k] = $i % 10;
    $i = intval($i / 10);
  }
  $q = array(
    "bigint_sign"=>true,
    "bigint_len"=>$size,
    "bigint_chiffres"=>$t
  );
  
  return $q;
}

function &fact_bigint(&$a){
  $one = bigint_of_int(1);
  $out0 = $one;
  while (!bigint_eq($a, $one))
  {
    $out0 = mul_bigint($a, $out0);
    $a = sub_bigint($a, $one);
  }
  return $out0;
}

function sum_chiffres_bigint(&$a){
  $out0 = 0;
  for ($i = 0 ; $i < $a["bigint_len"]; $i++)
    $out0 += $a["bigint_chiffres"][$i];
  return $out0;
}

/* http://projecteuler.net/problem=20 */
function euler20(){
  $a = bigint_of_int(15);
  /* normalement c'est 100 */
  $a = fact_bigint($a);
  return sum_chiffres_bigint($a);
}

function &bigint_exp(&$a, $b){
  if ($b == 1)
    return $a;
  else if (($b % 2) == 0)
    return bigint_exp(mul_bigint($a, $a), intval($b / 2));
  else
    return mul_bigint($a, bigint_exp($a, $b - 1));
}

function &bigint_exp_10chiffres(&$a, $b){
  $a = bigint_premiers_chiffres($a, 10);
  if ($b == 1)
    return $a;
  else if (($b % 2) == 0)
    return bigint_exp_10chiffres(mul_bigint($a, $a), intval($b / 2));
  else
    return mul_bigint($a, bigint_exp_10chiffres($a, $b - 1));
}

function euler48(){
  $sum = bigint_of_int(0);
  for ($i = 1 ; $i <= 100; $i++)
  {
    /* 1000 normalement */
    $ib = bigint_of_int($i);
    $ibeib = bigint_exp_10chiffres($ib, $i);
    $sum = add_bigint($sum, $ibeib);
    $sum = bigint_premiers_chiffres($sum, 10);
  }
  echo "euler 48 = ";
  print_bigint($sum);
  echo "\n";
}

function euler16(){
  $a = bigint_of_int(2);
  $a = bigint_exp($a, 100);
  /* 1000 normalement */
  return sum_chiffres_bigint($a);
}

function euler25(){
  $i = 2;
  $a = bigint_of_int(1);
  $b = bigint_of_int(1);
  while ($b["bigint_len"] < 100)
  {
    /* 1000 normalement */
    $c = add_bigint($a, $b);
    $a = $b;
    $b = $c;
    $i ++;
  }
  return $i;
}

function euler29(){
  $maxA = 5;
  $maxB = 5;
  $a_bigint = array();
  for ($j = 0 ; $j < $maxA + 1; $j++)
    $a_bigint[$j] = bigint_of_int($j * $j);
  $a0_bigint = array();
  for ($j2 = 0 ; $j2 < $maxA + 1; $j2++)
    $a0_bigint[$j2] = bigint_of_int($j2);
  $b = array();
  for ($k = 0 ; $k < $maxA + 1; $k++)
    $b[$k] = 2;
  $n = 0;
  $found = true;
  while ($found)
  {
    $min0 = $a0_bigint[0];
    $found = false;
    for ($i = 2 ; $i <= $maxA; $i++)
      if ($b[$i] <= $maxB)
    {
      if ($found)
      {
        if (bigint_lt($a_bigint[$i], $min0))
          $min0 = $a_bigint[$i];
      }
      else
      {
        $min0 = $a_bigint[$i];
        $found = true;
      }
    }
    if ($found)
    {
      $n ++;
      for ($l = 2 ; $l <= $maxA; $l++)
        if (bigint_eq($a_bigint[$l], $min0) && $b[$l] <= $maxB)
      {
        $b[$l] = $b[$l] + 1;
        $a_bigint[$l] = mul_bigint($a_bigint[$l], $a0_bigint[$l]);
      }
    }
  }
  return $n;
}

echo euler29(), "\n";
$sum = read_bigint(50);
for ($i = 2 ; $i <= 100; $i++)
{
  scantrim();
  $tmp = read_bigint(50);
  $sum = add_bigint($sum, $tmp);
}
echo "euler13 = ";
print_bigint($sum);
echo "\n", "euler25 = ", euler25(), "\n", "euler16 = ", euler16(), "\n";
euler48();
echo "euler20 = ", euler20(), "\n";
$a = bigint_of_int(999999);
$b = bigint_of_int(9951263);
print_bigint($a);
echo ">>1=";
print_bigint(bigint_shift($a, -1));
echo "\n";
print_bigint($a);
echo "*";
print_bigint($b);
echo "=";
print_bigint(mul_bigint($a, $b));
echo "\n";
print_bigint($a);
echo "*";
print_bigint($b);
echo "=";
print_bigint(mul_bigint_cp($a, $b));
echo "\n";
print_bigint($a);
echo "+";
print_bigint($b);
echo "=";
print_bigint(add_bigint($a, $b));
echo "\n";
print_bigint($b);
echo "-";
print_bigint($a);
echo "=";
print_bigint(sub_bigint($b, $a));
echo "\n";
print_bigint($a);
echo "-";
print_bigint($b);
echo "=";
print_bigint(sub_bigint($a, $b));
echo "\n";
print_bigint($a);
echo ">";
print_bigint($b);
echo "=";
$r = bigint_gt($a, $b);
if ($r)
  echo "True";
else
  echo "False";
echo "\n";
?>
