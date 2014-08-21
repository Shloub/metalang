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

sub read_int{
  my $out_ = 0;
  $out_ = readint();
  readspaces();
  return $out_;
}

sub read_char_line{
  my($n) = @_;
  my $tab = [];
  foreach my $i (0 .. $n - 1) {
    my $t = '_';
    $t = readchar();
    $tab->[$i] = $t;
    }
  readspaces();
  return $tab;
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

my $taille1 = read_int();
my $taille2 = read_int();
my $tableau1 = read_char_line($taille1);
my $tableau2 = read_char_line($taille2);
print(programme_candidat($tableau1, $taille1, $tableau2, $taille2), "\n");


