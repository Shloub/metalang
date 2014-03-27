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


function read_bigint(){
  $len = 0;
  list($len) = scan("%d");
  scantrim();
  $sign = '_';
  $sign = nextChar();
  scantrim();
  $chiffres = array();
  for ($d = 0 ; $d < $len; $d++)
  {
    $c = '_';
    $c = nextChar();
    $chiffres[$d] = ord($c) - ord('0');
  }
  for ($i = 0 ; $i <= intval(($len - 1) / 2); $i++)
  {
    $tmp = $chiffres[$i];
    $chiffres[$i] = $chiffres[$len - 1 - $i];
    $chiffres[$len - 1 - $i] = $tmp;
  }
  scantrim();
  $h = array(
    "bigint_sign"=>$sign == '+',
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  $out_ = $h;
  return $out_;
}

function print_bigint(&$a){
  if (!$a["bigint_sign"])
    echo '-';
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
          return $a["bigint_sign"];
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
  if ($chiffres[$len - 1] == 0)
    $len --;
  $m = array(
    "bigint_sign"=>true,
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  $out_ = $m;
  return $out_;
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
  $n = array(
    "bigint_sign"=>true,
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  $out_ = $n;
  return $out_;
}

function neg_bigint(&$a){
  $o = array(
    "bigint_sign"=>!$a["bigint_sign"],
    "bigint_len"=>$a["bigint_len"],
    "bigint_chiffres"=>$a["bigint_chiffres"]
  );
  
  $out_ = $o;
  return $out_;
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
    if ($chiffres[$len - 1] == 0)
    $len --;
  $p = array(
    "bigint_sign"=>$a["bigint_sign"] == $b["bigint_sign"],
    "bigint_len"=>$len,
    "bigint_chiffres"=>$chiffres
  );
  
  $out_ = $p;
  return $out_;
}

function bigint_premiers_chiffres(&$a, $i){
  $q = array(
    "bigint_sign"=>$a["bigint_sign"],
    "bigint_len"=>$i,
    "bigint_chiffres"=>$a["bigint_chiffres"]
  );
  
  $out_ = $q;
  return $out_;
}

function bigint_shift(&$a, $i){
  $f = $a["bigint_len"] + $i;
  $chiffres = array();
  for ($k = 0 ; $k < $f; $k++)
    if ($k >= $i)
    $chiffres[$k] = $a["bigint_chiffres"][$k - $i];
  else
    $chiffres[$k] = 0;
  $r = array(
    "bigint_sign"=>$a["bigint_sign"],
    "bigint_len"=>$a["bigint_len"] + $i,
    "bigint_chiffres"=>$chiffres
  );
  
  $out_ = $r;
  return $out_;
}

function mul_bigint(&$aa, &$bb){
  if ($aa["bigint_len"] < 3 || $bb["bigint_len"] < 3)
    return mul_bigint_cp($aa, $bb);
  /* Algorithme de Karatsuba */
  $split = intval(max2($aa["bigint_len"], $bb["bigint_len"]) / 2);
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
Exp
*/
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
$g = bigint_gt($a, $b);
if ($g)
  echo "True";
else
  echo "False";
echo "\n";
?>
