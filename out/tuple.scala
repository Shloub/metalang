object tuple
{
  
  def f(tuple0 : (Int, Int)): (Int, Int) = {
    var (a, b) = tuple0
    return (a + 1, b + 1);
  }
  
  
  def main(args : Array[String])
  {
    var t: (Int, Int) = f((0, 1));
    var (a, b) = t
    printf("%d -- %d--\n", a, b);
  }
  
}

