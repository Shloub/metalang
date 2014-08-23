#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  if (!defined $currentchar){ nextchar() ; }
  my $o = $currentchar;
  nextchar();
  return $o;
}
sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub max2{
  my($a,
  $b) = @_;
  if ($a > $b) {
  return $a;
  }else{
  return $b;
  }
}

sub min2{
  my($a,
  $b) = @_;
  if ($a < $b) {
  return $a;
  }else{
  return $b;
  }
}


sub read_bigint{
  my($len) = @_;
  my $chiffres = [];
  foreach my $j (0 .. $len - 1) {
    my $c = '_';
    $c = readchar();
    $chiffres->[$j] = ord($c);
    }
  foreach my $i (0 .. int(($len - 1) / (2))) {
    my $tmp = $chiffres->[$i];
    $chiffres->[$i] = $chiffres->[$len - 1 - $i];
    $chiffres->[$len - 1 - $i] = $tmp;
    }
  my $o = {"bigint_sign"=>1,
           "bigint_len"=>$len,
           "bigint_chiffres"=>$chiffres};
  return $o;
}

sub print_bigint{
  my($a) = @_;
  if (!$a->{"bigint_sign"}) {
  print('-');
  }else{
  
  }
  foreach my $i (0 .. $a->{"bigint_len"} - 1) {
    print($a->{"bigint_chiffres"}->[$a->{"bigint_len"}
    -
    1
    -
    $i]);
    }
}

sub bigint_eq{
  my($a,
  $b) = @_;
  # Renvoie vrai si a = b 
  
  if ($a->{"bigint_sign"} ne $b->{"bigint_sign"}) {
  return 0;
  }else{
  if ($a->{"bigint_len"} ne $b->{"bigint_len"}) {
  return 0;
  }else{
  foreach my $i (0 .. $a->{"bigint_len"} - 1) {
    if ($a->{"bigint_chiffres"}->[$i] ne $b->{"bigint_chiffres"}->[$i]) {
    return 0;
    }else{
    
    }
    }
  return 1;
  }
  }
}

sub bigint_gt{
  my($a,
  $b) = @_;
  # Renvoie vrai si a > b 
  
  if ($a->{"bigint_sign"} && !$b->{"bigint_sign"}) {
  return 1;
  }else{
  if (!$a->{"bigint_sign"} && $b->{"bigint_sign"}) {
  return 0;
  }else{
  if ($a->{"bigint_len"} > $b->{"bigint_len"}) {
  return $a->{"bigint_sign"};
  }else{
  if ($a->{"bigint_len"} < $b->{"bigint_len"}) {
  return !$a->{"bigint_sign"};
  }else{
  foreach my $i (0 .. $a->{"bigint_len"} - 1) {
    my $j = $a->{"bigint_len"} - 1 - $i;
    if ($a->{"bigint_chiffres"}->[$j] > $b->{"bigint_chiffres"}->[$j]) {
    return $a->{"bigint_sign"};
    }else{
    if ($a->{"bigint_chiffres"}->[$j] < $b->{"bigint_chiffres"}->[$j]) {
    return !$a->{"bigint_sign"};
    }else{
    
    }
    }
    }
  }
  }
  return 1;
  }
  }
}

sub bigint_lt{
  my($a,
  $b) = @_;
  return !bigint_gt($a, $b);
}

sub add_bigint_positif{
  my($a,
  $b) = @_;
  # Une addition ou on en a rien a faire des signes 
  
  my $len = max2($a->{"bigint_len"}, $b->{"bigint_len"}) + 1;
  my $retenue = 0;
  my $chiffres = [];
  foreach my $i (0 .. $len - 1) {
    my $tmp = $retenue;
    if ($i < $a->{"bigint_len"}) {
    $tmp = $tmp + $a->{"bigint_chiffres"}->[$i];
    }else{
    
    }
    if ($i < $b->{"bigint_len"}) {
    $tmp = $tmp + $b->{"bigint_chiffres"}->[$i];
    }else{
    
    }
    $retenue = int(($tmp) / (10));
    $chiffres->[$i] = remainder($tmp, 10);
    }
  while ($len > 0 && $chiffres->[$len - 1] eq 0)
  {
    $len = $len - 1;
  }
  my $p = {"bigint_sign"=>1,
           "bigint_len"=>$len,
           "bigint_chiffres"=>$chiffres};
  return $p;
}

sub sub_bigint_positif{
  my($a,
  $b) = @_;
  # Une soustraction ou on en a rien a faire des signes
  #Pré-requis : a > b
  #
  
  my $len = $a->{"bigint_len"};
  my $retenue = 0;
  my $chiffres = [];
  foreach my $i (0 .. $len - 1) {
    my $tmp = $retenue + $a->{"bigint_chiffres"}->[$i];
    if ($i < $b->{"bigint_len"}) {
    $tmp = $tmp - $b->{"bigint_chiffres"}->[$i];
    }else{
    
    }
    if ($tmp < 0) {
    $tmp = $tmp + 10;
    $retenue = -1;
    }else{
    $retenue = 0;
    }
    $chiffres->[$i] = $tmp;
    }
  while ($len > 0 && $chiffres->[$len - 1] eq 0)
  {
    $len = $len - 1;
  }
  my $q = {"bigint_sign"=>1,
           "bigint_len"=>$len,
           "bigint_chiffres"=>$chiffres};
  return $q;
}

sub neg_bigint{
  my($a) = @_;
  my $r = {"bigint_sign"=>!$a->{"bigint_sign"},
           "bigint_len"=>$a->{"bigint_len"},
           "bigint_chiffres"=>$a->{"bigint_chiffres"}};
  return $r;
}

sub add_bigint{
  my($a,
  $b) = @_;
  if ($a->{"bigint_sign"} eq $b->{"bigint_sign"}) {
  if ($a->{"bigint_sign"}) {
  return add_bigint_positif($a, $b);
  }else{
  return neg_bigint(add_bigint_positif($a, $b));
  }
  }else{
  if ($a->{"bigint_sign"}) {
  # a positif, b negatif 
  
  if (bigint_gt($a, neg_bigint($b))) {
  return sub_bigint_positif($a, $b);
  }else{
  return neg_bigint(sub_bigint_positif($b, $a));
  }
  }else{
  # a negatif, b positif 
  
  if (bigint_gt(neg_bigint($a), $b)) {
  return neg_bigint(sub_bigint_positif($a, $b));
  }else{
  return sub_bigint_positif($b, $a);
  }
  }
  }
}

sub sub_bigint{
  my($a,
  $b) = @_;
  return add_bigint($a, neg_bigint($b));
}

sub mul_bigint_cp{
  my($a,
  $b) = @_;
  # Cet algorithm est quadratique.
  #C'est le même que celui qu'on enseigne aux enfants en CP.
  #D'ou le nom de la fonction. 
  
  my $len = $a->{"bigint_len"} + $b->{"bigint_len"} + 1;
  my $chiffres = [];
  foreach my $k (0 .. $len - 1) {
    $chiffres->[$k] = 0;
    }
  foreach my $i (0 .. $a->{"bigint_len"} - 1) {
    my $retenue = 0;
    foreach my $j (0 .. $b->{"bigint_len"} - 1) {
      $chiffres->[$i + $j] = $chiffres->[$i + $j] + $retenue + $b->{"bigint_chiffres"}->[$j] * $a->{"bigint_chiffres"}->[$i];
      $retenue = int(($chiffres->[$i + $j]) / (10));
      $chiffres->[$i + $j] = remainder($chiffres->[$i + $j], 10);
      }
    $chiffres->[$i + $b->{"bigint_len"}] = $chiffres->[$i + $b->{"bigint_len"}] + $retenue;
    }
  $chiffres->[$a->{"bigint_len"} + $b->{"bigint_len"}] = int(($chiffres->[$a->{"bigint_len"} + $b->{"bigint_len"} - 1]) / (10));
  $chiffres->[$a->{"bigint_len"} + $b->{"bigint_len"} - 1] = remainder($chiffres->[$a->{"bigint_len"} + $b->{"bigint_len"} - 1], 10);
  foreach my $l (0 .. 2) {
    if ($len ne 0 && $chiffres->[$len - 1] eq 0) {
    $len = $len - 1;
    }else{
    
    }
    }
  my $s = {"bigint_sign"=>$a->{"bigint_sign"} eq $b->{"bigint_sign"},
           "bigint_len"=>$len,
           "bigint_chiffres"=>$chiffres};
  return $s;
}

sub bigint_premiers_chiffres{
  my($a,
  $i) = @_;
  my $len = min2($i, $a->{"bigint_len"});
  while ($len ne 0 && $a->{"bigint_chiffres"}->[$len - 1] eq 0)
  {
    $len = $len - 1;
  }
  my $u = {"bigint_sign"=>$a->{"bigint_sign"},
           "bigint_len"=>$len,
           "bigint_chiffres"=>$a->{"bigint_chiffres"}};
  return $u;
}

sub bigint_shift{
  my($a,
  $i) = @_;
  my $chiffres = [];
  foreach my $k (0 .. $a->{"bigint_len"} + $i - 1) {
    if ($k >= $i) {
    $chiffres->[$k] = $a->{"bigint_chiffres"}->[$k - $i];
    }else{
    $chiffres->[$k] = 0;
    }
    }
  my $v = {"bigint_sign"=>$a->{"bigint_sign"},
           "bigint_len"=>$a->{"bigint_len"} + $i,
           "bigint_chiffres"=>$chiffres};
  return $v;
}

sub mul_bigint{
  my($aa,
  $bb) = @_;
  if ($aa->{"bigint_len"} eq 0) {
  return $aa;
  }else{
  if ($bb->{"bigint_len"} eq 0) {
  return $bb;
  }else{
  if ($aa->{"bigint_len"} < 3 || $bb->{"bigint_len"} < 3) {
  return mul_bigint_cp($aa, $bb);
  }else{
  
  }
  }
  }
  # Algorithme de Karatsuba 
  
  my $split = int((min2($aa->{"bigint_len"}, $bb->{"bigint_len"})) / (2));
  my $a = bigint_shift($aa, -$split);
  my $b = bigint_premiers_chiffres($aa, $split);
  my $c = bigint_shift($bb, -$split);
  my $d = bigint_premiers_chiffres($bb, $split);
  my $amoinsb = sub_bigint($a, $b);
  my $cmoinsd = sub_bigint($c, $d);
  my $ac = mul_bigint($a, $c);
  my $bd = mul_bigint($b, $d);
  my $amoinsbcmoinsd = mul_bigint($amoinsb, $cmoinsd);
  my $acdec = bigint_shift($ac, 2 * $split);
  return add_bigint(add_bigint($acdec, $bd), bigint_shift(sub_bigint(add_bigint($ac, $bd), $amoinsbcmoinsd), $split));
  # ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd 
  
}

#
#Division,
#Modulo
#

sub log10{
  my($a) = @_;
  my $out_ = 1;
  while ($a >= 10)
  {
    $a = int(($a) / (10));
    $out_ = $out_ + 1;
  }
  return $out_;
}

sub bigint_of_int{
  my($i) = @_;
  my $size = log10($i);
  if ($i eq 0) {
  $size = 0;
  }else{
  
  }
  my $t = [];
  foreach my $j (0 .. $size - 1) {
    $t->[$j] = 0;
    }
  foreach my $k (0 .. $size - 1) {
    $t->[$k] = remainder($i, 10);
    $i = int(($i) / (10));
    }
  my $w = {"bigint_sign"=>1,
           "bigint_len"=>$size,
           "bigint_chiffres"=>$t};
  return $w;
}

sub fact_bigint{
  my($a) = @_;
  my $one = bigint_of_int(1);
  my $out_ = $one;
  while (!bigint_eq($a, $one))
  {
    $out_ = mul_bigint($a, $out_);
    $a = sub_bigint($a, $one);
  }
  return $out_;
}

sub sum_chiffres_bigint{
  my($a) = @_;
  my $out_ = 0;
  foreach my $i (0 .. $a->{"bigint_len"} - 1) {
    $out_ = $out_ + $a->{"bigint_chiffres"}->[$i];
    }
  return $out_;
}

# http://projecteuler.net/problem=20 

sub euler20{
  my $a = bigint_of_int(15);
  # normalement c'est 100 
  
  $a = fact_bigint($a);
  return sum_chiffres_bigint($a);
}

sub bigint_exp{
  my($a,
  $b) = @_;
  if ($b eq 1) {
  return $a;
  }else{
  if ((remainder($b, 2)) eq 0) {
  return bigint_exp(mul_bigint($a, $a), int(($b) / (2)));
  }else{
  return mul_bigint($a, bigint_exp($a, $b - 1));
  }
  }
}

sub bigint_exp_10chiffres{
  my($a,
  $b) = @_;
  $a = bigint_premiers_chiffres($a, 10);
  if ($b eq 1) {
  return $a;
  }else{
  if ((remainder($b, 2)) eq 0) {
  return bigint_exp_10chiffres(mul_bigint($a, $a), int(($b) / (2)));
  }else{
  return mul_bigint($a, bigint_exp_10chiffres($a, $b - 1));
  }
  }
}

sub euler48{
  my $sum = bigint_of_int(0);
  foreach my $i (1 .. 100) {
    # 1000 normalement 
    
    my $ib = bigint_of_int($i);
    my $ibeib = bigint_exp_10chiffres($ib, $i);
    $sum = add_bigint($sum, $ibeib);
    $sum = bigint_premiers_chiffres($sum, 10);
    }
  print("euler 48 = ");
  print_bigint($sum);
  print("\n");
}

sub euler16{
  my $a = bigint_of_int(2);
  $a = bigint_exp($a, 100);
  # 1000 normalement 
  
  return sum_chiffres_bigint($a);
}

sub euler25{
  my $i = 2;
  my $a = bigint_of_int(1);
  my $b = bigint_of_int(1);
  while ($b->{"bigint_len"} < 100)
  {
    # 1000 normalement 
    
    my $c = add_bigint($a, $b);
    $a = $b;
    $b = $c;
    $i = $i + 1;
  }
  return $i;
}

sub euler29{
  my $maxA = 5;
  my $maxB = 5;
  my $a_bigint = [];
  foreach my $j (0 .. $maxA + 1 - 1) {
    $a_bigint->[$j] = bigint_of_int($j * $j);
    }
  my $a0_bigint = [];
  foreach my $j2 (0 .. $maxA + 1 - 1) {
    $a0_bigint->[$j2] = bigint_of_int($j2);
    }
  my $b = [];
  foreach my $k (0 .. $maxA + 1 - 1) {
    $b->[$k] = 2;
    }
  my $n = 0;
  my $found = 1;
  while ($found)
  {
    my $min_ = $a0_bigint->[0];
    $found = 0;
    foreach my $i (2 .. $maxA) {
      if ($b->[$i] <= $maxB) {
      if ($found) {
      if (bigint_lt($a_bigint->[$i], $min_)) {
      $min_ = $a_bigint->[$i];
      }else{
      
      }
      }else{
      $min_ = $a_bigint->[$i];
      $found = 1;
      }
      }else{
      
      }
      }
    if ($found) {
    $n = $n + 1;
    foreach my $l (2 .. $maxA) {
      if (bigint_eq($a_bigint->[$l], $min_) && $b->[$l] <= $maxB) {
      $b->[$l] = $b->[$l] + 1;
      $a_bigint->[$l] = mul_bigint($a_bigint->[$l], $a0_bigint->[$l]);
      }else{
      
      }
      }
    }else{
    
    }
  }
  return $n;
}

print(euler29(), "\n");
my $sum = read_bigint(50);
foreach my $i (2 .. 100) {
  readspaces();
  my $tmp = read_bigint(50);
  $sum = add_bigint($sum, $tmp);
  }
print("euler13 = ");
print_bigint($sum);
print("\n", "euler25 = ", euler25(), "\n", "euler16 = ", euler16(), "\n");
euler48();
print("euler20 = ", euler20(), "\n");
my $a = bigint_of_int(999999);
my $b = bigint_of_int(9951263);
print_bigint($a);
print(">>1=");
print_bigint(bigint_shift($a, -1));
print("\n");
print_bigint($a);
print("*");
print_bigint($b);
print("=");
print_bigint(mul_bigint($a, $b));
print("\n");
print_bigint($a);
print("*");
print_bigint($b);
print("=");
print_bigint(mul_bigint_cp($a, $b));
print("\n");
print_bigint($a);
print("+");
print_bigint($b);
print("=");
print_bigint(add_bigint($a, $b));
print("\n");
print_bigint($b);
print("-");
print_bigint($a);
print("=");
print_bigint(sub_bigint($b, $a));
print("\n");
print_bigint($a);
print("-");
print_bigint($b);
print("=");
print_bigint(sub_bigint($a, $b));
print("\n");
print_bigint($a);
print(">");
print_bigint($b);
print("=");
my $m = bigint_gt($a, $b);
if ($m) {
print("True");
}else{
print("False");
}
print("\n");


