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
function max2($a, $b){
  if ($a > $b)
    return $a;
  return $b;
}

function min2($a, $b){
  if ($a < $b)
    return $a;
  return $b;
}


function read_bigint(){
  $len = 0;
  list($len) = scan("%d");
  scantrim();
  $sign = "_";
  $sign = nextChar();
  scantrim();
  $chiffres = array();
  for ($d = 0 ; $d < $len; $d++)
  {
    $c = "_";
    $c = nextChar();
    $chiffres[$d] = ord($c) - ord("0");
  }
  for ($i = 0 ; $i <= intval(($len - 1) / 2); $i++)
  {
    $tmp = $chiffres[$i];
    $chiffres[$i] = $chiffres[$len - 1 - $i];
    $chiffres[$len - 1 - $i] = $tmp;
  }
  scantrim();
  $m = array(
    "bigint_sign"=>$sign == "+",
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  return $m;
}

function print_bigint(&$a){
  if (!$a["bigint_sign"])
    echo "-";
  for ($i = 0 ; $i < $a["bigint_len"]; $i++)
  {
    $e = $a["bigint_chiffres"][$a["bigint_len"] - 1 - $i];
    echo $e;
  }
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

function add_bigint_positif(&$a, &$b){
  /* Une addition ou on en a rien a faire des signes */
  $len = max2($a["bigint_len"], $b["bigint_len"]) + 1;
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
  $n = array(
    "bigint_sign"=>true,
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  return $n;
}

function sub_bigint_positif(&$a, &$b){
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
  $o = array(
    "bigint_sign"=>true,
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  return $o;
}

function neg_bigint(&$a){
  $p = array(
    "bigint_sign"=>!$a["bigint_sign"],
    "bigint_len"=>$a["bigint_len"],
    "bigint_chiffres"=>$a["bigint_chiffres"]
  );
  
  return $p;
}

function add_bigint(&$a, &$b){
  if ($a["bigint_sign"] == $b["bigint_sign"])
    if ($a["bigint_sign"])
    return add_bigint_positif($a, $b);
  else
    return neg_bigint(add_bigint_positif($a, $b));
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

function sub_bigint(&$a, &$b){
  return add_bigint($a, neg_bigint($b));
}

function mul_bigint_cp(&$a, &$b){
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
      $chiffres[$i + $j] = $chiffres[$i + $j] + $retenue + $b["bigint_chiffres"][$j] * $a["bigint_chiffres"][$i];
      $retenue = intval($chiffres[$i + $j] / 10);
      $chiffres[$i + $j] = $chiffres[$i + $j] % 10;
    }
    $chiffres[$i + $b["bigint_len"]] = $chiffres[$i + $b["bigint_len"]] + $retenue;
  }
  $chiffres[$a["bigint_len"] + $b["bigint_len"]] = intval($chiffres[$a["bigint_len"] + $b["bigint_len"] - 1] / 10);
  $chiffres[$a["bigint_len"] + $b["bigint_len"] - 1] = $chiffres[$a["bigint_len"] + $b["bigint_len"] - 1] % 10;
  for ($l = 0 ; $l <= 2; $l++)
    if ($len != 0 && $chiffres[$len - 1] == 0)
    $len --;
  $q = array(
    "bigint_sign"=>$a["bigint_sign"] == $b["bigint_sign"],
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  return $q;
}

function bigint_premiers_chiffres(&$a, $i){
  $len = min2($i, $a["bigint_len"]);
  while ($len != 0 && $a["bigint_chiffres"][$len - 1] == 0)
    $len --;
  $r = array(
    "bigint_sign"=>$a["bigint_sign"],
    "bigint_len"=>$len,
    "bigint_chiffres"=>$a["bigint_chiffres"]
  );
  
  return $r;
}

function bigint_shift(&$a, $i){
  $f = $a["bigint_len"] + $i;
  $chiffres = array();
  for ($k = 0 ; $k < $f; $k++)
    if ($k >= $i)
    $chiffres[$k] = $a["bigint_chiffres"][$k - $i];
  else
    $chiffres[$k] = 0;
  $s = array(
    "bigint_sign"=>$a["bigint_sign"],
    "bigint_len"=>$a["bigint_len"] + $i,
    "bigint_chiffres"=>$chiffres
  );
  
  return $s;
}

function mul_bigint(&$aa, &$bb){
  if ($aa["bigint_len"] == 0)
    return $aa;
  else if ($bb["bigint_len"] == 0)
    return $bb;
  else if ($aa["bigint_len"] < 3 || $bb["bigint_len"] < 3)
    return mul_bigint_cp($aa, $bb);
  /* Algorithme de Karatsuba */
  $split = intval(min2($aa["bigint_len"], $bb["bigint_len"]) / 2);
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
function log10_($a){
  $out_ = 1;
  while ($a >= 10)
  {
    $a = intval($a / 10);
    $out_ ++;
  }
  return $out_;
}

function bigint_of_int($i){
  $size = log10_($i);
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
  $u = array(
    "bigint_sign"=>true,
    "bigint_len"=>$size,
    "bigint_chiffres"=>$t
  );
  
  return $u;
}

function fact_bigint(&$a){
  $one = bigint_of_int(1);
  $out_ = $one;
  while (!bigint_eq($a, $one))
  {
    $out_ = mul_bigint($a, $out_);
    $a = sub_bigint($a, $one);
  }
  return $out_;
}

function sum_chiffres_bigint(&$a){
  $out_ = 0;
  for ($i = 0 ; $i < $a["bigint_len"]; $i++)
    $out_ += $a["bigint_chiffres"][$i];
  return $out_;
}

/* http://projecteuler.net/problem=20 */
function euler20(){
  $a = bigint_of_int(100);
  $a = fact_bigint($a);
  return sum_chiffres_bigint($a);
}

function bigint_exp_10chiffres(&$a, $b){
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
  for ($i = 1 ; $i <= 1000; $i++)
  {
    $ib = bigint_of_int($i);
    $ibeib = bigint_exp_10chiffres($ib, $i);
    $sum = add_bigint($sum, $ibeib);
    $sum = bigint_premiers_chiffres($sum, 10);
  }
  echo "euler 48 = ";
  print_bigint($sum);
  echo "\n";
}

euler48();
echo "euler20 = ";
$g = euler20();
echo $g, "\n";
$a = read_bigint();
$b = read_bigint();
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
$h = bigint_gt($a, $b);
if ($h)
  echo "True";
else
  echo "False";
echo "\n";
?>
