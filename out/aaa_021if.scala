object aaa_021if
{
  
  def testA(a : Boolean, b : Boolean){
    if (a)
        if (b)
            printf("A");
        else
            printf("B");
    else
        if (b)
            printf("C");
        else
            printf("D");
  }
  
  def testB(a : Boolean, b : Boolean){
    if (a)
        printf("A");
    else
        if (b)
            printf("B");
        else
            printf("C");
  }
  
  def testC(a : Boolean, b : Boolean){
    if (a)
        if (b)
            printf("A");
        else
            printf("B");
    else
        printf("C");
  }
  
  def testD(a : Boolean, b : Boolean){
    if (a)
    {
        if (b)
            printf("A");
        else
            printf("B");
        printf("C");
    }
    else
        printf("D");
  }
  
  def testE(a : Boolean, b : Boolean){
    if (a)
    {
        if (b)
            printf("A");
    }
    else
    {
        if (b)
            printf("C");
        else
            printf("D");
        printf("E");
    }
  }
  
  def test(a : Boolean, b : Boolean){
    testD(a, b);
    testE(a, b);
    printf("\n");
  }
  
  
  def main(args : Array[String])
  {
    test(true, true);
    test(true, false);
    test(false, true);
    test(false, false);
  }
  
}

