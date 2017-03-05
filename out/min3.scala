object min3
{
  
  def min2_0(a : Int, b : Int): Int = {
    if (a < b)
        return a;
    else
        return b;
  }
  
  def main(args : Array[String])
  {
    printf("%d %d %d %d %d %d\n", min2_0(min2_0(2, 3), 4), min2_0(min2_0(2, 4), 3), min2_0(min2_0(3, 2), 4), min2_0(min2_0(3, 4), 2), min2_0(min2_0(4, 2), 3), min2_0(min2_0(4, 3), 2));
  }
  
}

