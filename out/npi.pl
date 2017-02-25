#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar;
  return $o;
}
sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0, $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar;
  }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar;
  }
  return $o * $sign;
}
sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar(); }
}

sub is_number{
  my($c) = @_;
  return ord($c) <= ord("9") && ord($c) >= ord("0");
}
#
#Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
#
sub npi0{
  my($str, $len) = @_;
  my $stack = [];
  foreach my $i (0 .. $len - 1)
  {
      $stack->[$i] = 0;
  }
  my $ptrStack = 0;
  my $ptrStr = 0;
  while ($ptrStr < $len)
  {
      if ($str->[$ptrStr] eq " ")
      {
          $ptrStr = $ptrStr + 1;
      }
      elsif (is_number($str->[$ptrStr]))
          {
              my $num = 0;
              while ($str->[$ptrStr] ne " ")
              {
                  $num = $num * 10 + ord($str->[$ptrStr]) - ord("0");
                  $ptrStr = $ptrStr + 1;
              }
              $stack->[$ptrStack] = $num;
              $ptrStack = $ptrStack + 1;
          }
          elsif ($str->[$ptrStr] eq "+")
              {
                  $stack->[$ptrStack - 2] = $stack->[$ptrStack - 2] + $stack->[$ptrStack - 1];
                  $ptrStack = $ptrStack - 1;
                  $ptrStr = $ptrStr + 1;
              }
  }
  return $stack->[0];
}
my $len = 0;
$len = readint();
readspaces();
my $tab = [];
foreach my $i (0 .. $len - 1)
{
    my $tmp = "\x00";
    $tmp = readchar();
    $tab->[$i] = $tmp;
}
my $result = npi0($tab, $len);
print $result;


