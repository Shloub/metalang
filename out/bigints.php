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


function read_big_int(){
  echo "read_big_int";
  $len = 0;
  list($len) = scan("%d");
  scantrim();
  echo $len, "=len ";
  $sign = '_';
  $sign = nextChar();
  echo $sign, "=sign\n";
  $chiffres = array();
  for ($d = 0 ; $d < $len; $d++)
  {
    $c = '_';
    $c = nextChar();
    echo $c, "=c\n";
    $chiffres[$d] = ord($c) - ord('0');
  }
  for ($i = 0 ; $i <= intval($len / 2); $i++)
  {
    $tmp = $chiffres[$i];
    $chiffres[$i] = $chiffres[$len - 1 - $i];
    $chiffres[$len - 1 - $i] = $tmp;
  }
  scantrim();
  $out_ = array(
    "sign"=>$sign == '+',
    "chiffres_len"=>$len,
    "chiffres"=>$chiffres
  );
  
  return $out_;
}

function print_big_int(&$a){
  if ($a["sign"])
    echo "+";
  else
    echo "-";
  for ($i = 0 ; $i < $a["chiffres_len"]; $i++)
  {
    $e = $a["chiffres"][$i];
    echo $e;
  }
}

function neg_big_int(&$a){
  $out_ = array(
    "sign"=>!$a["sign"],
    "chiffres_len"=>$a["chiffres_len"],
    "chiffres"=>$a["chiffres"]
  );
  
  return $out_;
}

function add_big_int(&$a, &$b){
  $len = max2($a["chiffres_len"], $b["chiffres_len"]) + 1;
  $retenue = 0;
  $sign = true;
  $chiffres = array();
  for ($i = 0 ; $i < $len; $i++)
  {
    $tmp = $retenue;
    if ($i < $a["chiffres_len"])
      $tmp += $a["chiffres"][$i];
    if ($i < $b["chiffres_len"])
      $tmp += $b["chiffres"][$i];
    $retenue = intval($tmp / 10);
    $chiffres[$i] = $tmp % 10;
  }
  $out_ = array(
    "sign"=>$sign,
    "chiffres_len"=>$len,
    "chiffres"=>$chiffres
  );
  
  return $out_;
}

/*
def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end
*/
$a = read_big_int();
$b = read_big_int();
print_big_int(add_big_int($a, $b));
?>
