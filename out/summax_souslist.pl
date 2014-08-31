#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
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

sub summax{
  my($lst,
  $len) = @_;
  my $current = 0;
  my $max_ = 0;
  foreach my $i (0 .. $len - 1) {
    $current = $current + $lst->[$i];
    if ($current < 0) {
    $current = 0;
    }
    if ($max_ < $current) {
    $max_ = $current;
    }
    }
  return $max_;
}

my $len = 0;
$len = readint();
readspaces();
my $tab = [];
foreach my $i (0 .. $len - 1) {
  my $tmp = 0;
  $tmp = readint();
  readspaces();
  $tab->[$i] = $tmp;
  }
my $result = summax($tab, $len);
print($result);


