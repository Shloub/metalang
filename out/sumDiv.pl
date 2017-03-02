#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
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
sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub foo{
  my $a = 0;
  # test 
  
  $a = $a + 1;
  # test 2 
  
}

sub foo2{
  
}

sub foo3{
  if (1 eq 1)
  {
      
  }
}

sub sumdiv{
  my($n) = @_;
  # On désire renvoyer la somme des diviseurs 
  
  my $out0 = 0;
  # On déclare un entier qui contiendra la somme 
  
  foreach my $i (1 .. $n)
  {
      # La boucle : i est le diviseur potentiel
      
      if (remainder($n, $i) eq 0)
      {
          # Si i divise 
          
          $out0 = $out0 + $i;
          # On incrémente 
          
      }
      else
      {
          # nop 
          
      }
  }
  return $out0;
  #On renvoie out
  
}
# Programme principal 

my $n = 0;
$n = readint();
# Lecture de l'entier 

print sumdiv($n);


