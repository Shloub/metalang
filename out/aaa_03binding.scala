object aaa_03binding
{
  
  def g(i : Int): Int = {
    var j: Int = i * 4;
    if (j % 2 == 1)
        return 0;
    return j;
  }
  
  def h(i : Int){
    printf("%d\n", i);
  }
  
  def main(args : Array[String])
  {
    h(14);
    var a: Int = 4;
    var b: Int = 5;
    printf("%d", a + b);
    /* main */
    h(15);
    a = 2;
    b = 1;
    printf("%d", a + b);
  }
  
}

