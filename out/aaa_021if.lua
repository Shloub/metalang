function testA (a, b)
  if a then
      if b then
          io.write("A")
      else 
          io.write("B")
      end
  elseif b then
      io.write("C")
  else 
      io.write("D")
  end
end
function testB (a, b)
  if a then
      io.write("A")
  elseif b then
      io.write("B")
  else 
      io.write("C")
  end
end
function testC (a, b)
  if a then
      if b then
          io.write("A")
      else 
          io.write("B")
      end
  else 
      io.write("C")
  end
end
function testD (a, b)
  if a then
      if b then
          io.write("A")
      else 
          io.write("B")
      end
      io.write("C")
  else 
      io.write("D")
  end
end
function testE (a, b)
  if a then
      if b then
          io.write("A")
      end
  else 
      if b then
          io.write("C")
      else 
          io.write("D")
      end
      io.write("E")
  end
end
function test (a, b)
  testD(a, b)
  testE(a, b)
  io.write("\n")
end

test(true, true)
test(true, false)
test(false, true)
test(false, false)
