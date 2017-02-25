#!/usr/bin/perl
use List::Util qw(min max);

sub pathfind_aux{
  my($cache, $tab, $x, $y, $posX, $posY) = @_;
  if ($posX eq $x - 1 && $posY eq $y - 1)
  {
      return 0;
  }
  elsif ($posX < 0 || $posY < 0 || $posX >= $x || $posY >= $y)
      {
          return $x * $y * 10;
      }
      elsif ($tab->[$posY]->[$posX] eq "#")
          {
              return $x * $y * 10;
          }
          elsif ($cache->[$posY]->[$posX] ne -1)
              {
                  return $cache->[$posY]->[$posX];
              }
              else
              {
                  $cache->[$posY]->[$posX] = $x * $y * 10;
                  my $val1 = pathfind_aux($cache, $tab, $x, $y, $posX + 1, $posY);
                  my $val2 = pathfind_aux($cache, $tab, $x, $y, $posX - 1, $posY);
                  my $val3 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY - 1);
                  my $val4 = pathfind_aux($cache, $tab, $x, $y, $posX, $posY + 1);
                  my $out0 = 1 + min($val1, $val2, $val3, $val4);
                  $cache->[$posY]->[$posX] = $out0;
                  return $out0;
              }
}
sub pathfind{
  my($tab, $x, $y) = @_;
  my $cache = [];
  foreach my $i (0 .. $y - 1)
  {
      my $tmp = [];
      foreach my $j (0 .. $x - 1)
      {
          print $tab->[$i]->[$j];
          $tmp->[$j] = -1;
      }
      print "\n";
      $cache->[$i] = $tmp;
  }
  return pathfind_aux($cache, $tab, $x, $y, 0, 0);
}
my $x = int( <STDIN> );
my $y = int( <STDIN> );
print($x, " ", $y, "\n");
my $e = [];
foreach my $f (0 .. $y - 1)
{
    $e->[$f] = [split(//, <STDIN>)];
}
my $tab = $e;
my $result = pathfind($tab, $x, $y);
print $result;


