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
sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar(); }
}

sub copytab{
  my($tab, $len) = @_;
  my $o = [];
  foreach my $i (0 .. $len - 1)
  {
      $o->[$i] = $tab->[$i];
  }
  return $o;
}
sub bubblesort{
  my($tab, $len) = @_;
  foreach my $i (0 .. $len - 1)
  {
      foreach my $j ($i + 1 .. $len - 1)
      {
          if ($tab->[$i] > $tab->[$j])
          {
              my $tmp = $tab->[$i];
              $tab->[$i] = $tab->[$j];
              $tab->[$j] = $tmp;
          }
      }
  }
}
sub qsort0{
  my($tab, $len, $i, $j) = @_;
  if ($i < $j)
  {
      my $i0 = $i;
      my $j0 = $j;
      # pivot : tab[0] 
      
      while ($i ne $j)
      {
          if ($tab->[$i] > $tab->[$j])
          {
              if ($i eq $j - 1)
              {
                  # on inverse simplement
                  
                  my $tmp = $tab->[$i];
                  $tab->[$i] = $tab->[$j];
                  $tab->[$j] = $tmp;
                  $i = $i + 1;
              }
              else
              {
                  # on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] 
                  
                  my $tmp = $tab->[$i];
                  $tab->[$i] = $tab->[$j];
                  $tab->[$j] = $tab->[$i + 1];
                  $tab->[$i + 1] = $tmp;
                  $i = $i + 1;
              }
          }
          else
          {
              $j = $j - 1;
          }
      }
      qsort0($tab, $len, $i0, $i - 1);
      qsort0($tab, $len, $i + 1, $j0);
  }
}
my $len = 2;
$len = readint();
readspaces();
my $tab = [];
foreach my $i_ (0 .. $len - 1)
{
    my $tmp = 0;
    $tmp = readint();
    readspaces();
    $tab->[$i_] = $tmp;
}
my $tab2 = copytab($tab, $len);
bubblesort($tab2, $len);
foreach my $i (0 .. $len - 1)
{
    print($tab2->[$i], " ");
}
print "\n";
my $tab3 = copytab($tab, $len);
qsort0($tab3, $len, 0, $len - 1);
foreach my $i (0 .. $len - 1)
{
    print($tab3->[$i], " ");
}
print "\n";


