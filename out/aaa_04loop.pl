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

sub h{
  my($i) = @_;
  #  for j = i - 2 to i + 2 do
  #    if i % j == 5 then return true end
  #  end 
  
  my $j = $i - 2;
  while ($j <= $i + 2)
  {
    if ((remainder($i, $j)) eq 5) {
    return 1;
    }else{
    
    }
    $j = $j + 1;
  }
  return 0;
}

my $j = 0;
foreach $k (0 .. 10) {
  $j = $j + $k;
  print($j);
  print("\n");
  }
my $i = 4;
while ($i < 10)
{
  print($i);
  $i = $i + 1;
  $j = $j + $i;
}
print($j);
print($i);
print("FIN TEST\n");


