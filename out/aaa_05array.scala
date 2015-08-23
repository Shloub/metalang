object aaa_05array
{
  
  def id(b : Array[Boolean]): Array[Boolean] = {
    return b;
  }
  
  def g(t : Array[Boolean], index : Int){
    t(index) = false;
  }
  
  
  def main(args : Array[String])
  {
    var j: Int = 0;
    var a :Array[Boolean] = new Array[Boolean](5);
    for (i <- 0 to 5 - 1)
    {
      printf("%d", i);
      j = j + i;
      a(i) = i % 2 == 0;
    }
    printf("%d ", j);
    if (a(0))
      printf("True");
    else
      printf("False");
    printf("\n");
    g(id(a), 0);
    if (a(0))
      printf("True");
    else
      printf("False");
    printf("\n");
  }
  
}

