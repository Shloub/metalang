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
  my($tableau,
  $taille) = @_;
  my $out_ = 0;
  foreach my $i (0 .. $taille - 1) {
    $out_ = $out_ + ord($tableau->[$i])
    *
    $i;
    print($tableau->[$i]);
    }
  print("--\n");
  return $out_;
}

my $taille = read_int();
my $tableau = read_char_line($taille);
print(programme_candidat($tableau, $taille), "\n");


