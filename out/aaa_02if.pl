#!/usr/bin/perl

sub f{
  my($i) = @_;
  if ($i eq 0)
  {
      return !(0);
  }
  return !(1);
}

if (f(4))
{
    print "true <-\n ->\n";
}
else
{
    print "false <-\n ->\n";
}
print "small test end\n";


