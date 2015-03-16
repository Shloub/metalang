object aaa_02if
{
  
  def f(i : Int): Boolean = {
    if (i == 0)
      return true;
    return false;
  }
  
  
  def main(args : Array[String])
  {
    if (f(4))
      printf("true <-\n ->\n");
    else
      printf("false <-\n ->\n");
    printf("small test end\n");
  }
  
}

