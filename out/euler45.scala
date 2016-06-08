object euler45
{
  
  def triangle(n : Int): Int = {
    if (n % 2 == 0)
        return (n / 2) * (n + 1);
    else
        return n * ((n + 1) / 2);
  }
  
  def penta(n : Int): Int = {
    if (n % 2 == 0)
        return (n / 2) * (3 * n - 1);
    else
        return ((3 * n - 1) / 2) * n;
  }
  
  def hexa(n : Int): Int = {
    return n * (2 * n - 1);
  }
  
  def findPenta2(n : Int, a : Int, b : Int): Boolean = {
    if (b == a + 1)
        return penta(a) == n || penta(b) == n;
    var c: Int = (a + b) / 2;
    var p: Int = penta(c);
    if (p == n)
        return true;
    else
        if (p < n)
            return findPenta2(n, c, b);
        else
            return findPenta2(n, a, c);
  }
  
  def findHexa2(n : Int, a : Int, b : Int): Boolean = {
    if (b == a + 1)
        return hexa(a) == n || hexa(b) == n;
    var c: Int = (a + b) / 2;
    var p: Int = hexa(c);
    if (p == n)
        return true;
    else
        if (p < n)
            return findHexa2(n, c, b);
        else
            return findHexa2(n, a, c);
  }
  
  
  def main(args : Array[String])
  {
    for (n <- 285 to 55385)
    
    {
        var t: Int = triangle(n);
        if (findPenta2(t, n / 5, n) && findHexa2(t, n / 5, n / 2 + 10))
            printf("%d\n%d\n", n, t);
    }
  }
  
}

