require "scanf.rb"
def testA( a, b )
  if a then
      if b then
          print "A"
      else 
          print "B"
      end
  elsif b then
      print "C"
  else 
      print "D"
  end
end

def testB( a, b )
  if a then
      print "A"
  elsif b then
      print "B"
  else 
      print "C"
  end
end

def testC( a, b )
  if a then
      if b then
          print "A"
      else 
          print "B"
      end
  else 
      print "C"
  end
end

def testD( a, b )
  if a then
      if b then
          print "A"
      else 
          print "B"
      end
      print "C"
  else 
      print "D"
  end
end

def testE( a, b )
  if a then
      if b then
          print "A"
      end
  else 
      if b then
          print "C"
      else 
          print "D"
      end
      print "E"
  end
end

def test( a, b )
  testD(a, b)
  testE(a, b)
  print "\n"
end
test(true, true)
test(true, false)
test(false, true)
test(false, false)

