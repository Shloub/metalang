#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  if (!defined $currentchar){ nextchar() ; }
  my $o = $currentchar;
  nextchar();
  return $o;
}
sub readint {
  if (!defined $currentchar){
     nextchar();
  }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar();
  }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub programme_candidat{
  my($tableau1,
  $taille1,
  $tableau2,
  $taille2) = @_;
  my $out_ = 0;
  foreach my $i (0 .. $taille1 - 1) {
    $out_ = $out_ + ord($tableau1->[$i])
    *
    $i;
    print($tableau1->[$i]);
    }
  print("--\n");
  foreach my $j (0 .. $taille2 - 1) {
    $out_ = $out_ + ord($tableau2->[$j])
    *
    $j
    *
    100;
    print($tableau2->[$j]);
    }
  print("--\n");
  return $out_;
}

my $b = 0;
$b = readint();
readspaces();
my $a = $b;
my $taille1 = $a;
my $d = [];
foreach my $e (0 .. $taille1 - 1) {
  my $f = '_';
  $f = readchar();
  $d->[$e] = $f;
  }
readspaces();
my $c = $d;
my $tableau1 = $c;
my $h = 0;
$h = readint();
readspaces();
my $g = $h;
my $taille2 = $g;
my $l = [];
foreach my $m (0 .. $taille2 - 1) {
  my $o = '_';
  $o = readchar();
  $l->[$m] = $o;
  }
readspaces();
my $k = $l;
my $tableau2 = $k;
print(programme_candidat($tableau1, $taille1, $tableau2, $taille2), "\n");


