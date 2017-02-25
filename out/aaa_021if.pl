#!/usr/bin/perl

sub testA{
  my($a, $b) = @_;
  if ($a)
  {
      if ($b)
      {
          print "A";
      }
      else
      {
          print "B";
      }
  }
  elsif ($b)
      {
          print "C";
      }
      else
      {
          print "D";
      }
}
sub testB{
  my($a, $b) = @_;
  if ($a)
  {
      print "A";
  }
  elsif ($b)
      {
          print "B";
      }
      else
      {
          print "C";
      }
}
sub testC{
  my($a, $b) = @_;
  if ($a)
  {
      if ($b)
      {
          print "A";
      }
      else
      {
          print "B";
      }
  }
  else
  {
      print "C";
  }
}
sub testD{
  my($a, $b) = @_;
  if ($a)
  {
      if ($b)
      {
          print "A";
      }
      else
      {
          print "B";
      }
      print "C";
  }
  else
  {
      print "D";
  }
}
sub testE{
  my($a, $b) = @_;
  if ($a)
  {
      if ($b)
      {
          print "A";
      }
  }
  else
  {
      if ($b)
      {
          print "C";
      }
      else
      {
          print "D";
      }
      print "E";
  }
}
sub test{
  my($a, $b) = @_;
  testD($a, $b);
  testE($a, $b);
  print "\n";
}
test(!(0), !(0));
test(!(0), !(1));
test(!(1), !(0));
test(!(1), !(1));


