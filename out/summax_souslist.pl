#!/usr/bin/perl

sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
    if (!defined $currentchar){ nextchar() ; }
    my $o = $currentchar; nextchar(); return $o; }
sub readint {
    if (!defined $currentchar){ nextchar(); }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') { $sign = -1; nextchar(); }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}

sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub summax{
  my($lst,
  $len) = @_;
  my $current = 0;
  my $max_ = 0;
  foreach $i (0 .. $len - 1) {
    $current = $current + $lst->[$i];
    if ($current < 0) {
    $current = 0;
    }else{
    
    }
    if ($max_ < $current) {
    $max_ = $current;
    }else{
    
    }
    }
  return $max_;
}

my $len = 0;
$len = readint();
readspaces();
my $tab = [];
foreach $i (0 .. $len - 1) {
  my $tmp = 0;
  $tmp = readint();
  readspaces();
  $tab->[$i] = $tmp;
  }
my $result = summax($tab, $len);
print($result);


