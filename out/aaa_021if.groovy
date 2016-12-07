import java.util.*

void testA(boolean a, boolean b)
{
  if (a)
      if (b)
          print("A")
      else
          print("B")
  else if (b)
      print("C")
  else
      print("D")
}

void testB(boolean a, boolean b)
{
  if (a)
      print("A")
  else if (b)
      print("B")
  else
      print("C")
}

void testC(boolean a, boolean b)
{
  if (a)
      if (b)
          print("A")
      else
          print("B")
  else
      print("C")
}

void testD(boolean a, boolean b)
{
  if (a)
  {
      if (b)
          print("A")
      else
          print("B")
      print("C")
  }
  else
      print("D")
}

void testE(boolean a, boolean b)
{
  if (a)
  {
      if (b)
          print("A")
  }
  else
  {
      if (b)
          print("C")
      else
          print("D")
      print("E")
  }
}

void test(boolean a, boolean b)
{
  testD(a, b)
  testE(a, b)
  print("\n")
}



test(true, true)
test(true, false)
test(false, true)
test(false, false)

