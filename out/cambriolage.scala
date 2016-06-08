object cambriolage
{
  
var buffer = "";
def read_int() : Int = {
  if (buffer != null && buffer == "") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != "" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}
  
  def max2_0(a : Int, b : Int): Int = {
    if (a > b)
        return a;
    else
        return b;
  }
  
  def nbPassePartout(n : Int, passepartout : Array[Array[Int]], m : Int, serrures : Array[Array[Int]]): Int = {
    var max_ancient: Int = 0;
    var max_recent: Int = 0;
    for (i <- 0 to m - 1)
    {
        if (serrures(i)(0) == -1 && serrures(i)(1) > max_ancient)
            max_ancient = serrures(i)(1);
        if (serrures(i)(0) == 1 && serrures(i)(1) > max_recent)
            max_recent = serrures(i)(1);
    }
    var max_ancient_pp: Int = 0;
    var max_recent_pp: Int = 0;
    for (i <- 0 to n - 1)
    {
        var pp: Array[Int] = passepartout(i);
        if (pp(0) >= max_ancient && pp(1) >= max_recent)
            return 1;
        max_ancient_pp = max2_0(max_ancient_pp, pp(0));
        max_recent_pp = max2_0(max_recent_pp, pp(1));
    }
    if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
        return 2;
    else
        return 0;
  }
  
  
  def main(args : Array[String])
  {
    var n = read_int();
    skip();
    var passepartout :Array[Array[Int]] = new Array[Array[Int]](n);
    for (i <- 0 to n - 1)
    {
        var out0 :Array[Int] = new Array[Int](2);
        for (j <- 0 to 2 - 1)
        {
            var out01 = read_int();
            skip();
            out0(j) = out01;
        }
        passepartout(i) = out0;
    }
    var m = read_int();
    skip();
    var serrures :Array[Array[Int]] = new Array[Array[Int]](m);
    for (k <- 0 to m - 1)
    {
        var out1 :Array[Int] = new Array[Int](2);
        for (l <- 0 to 2 - 1)
        {
            var out_0 = read_int();
            skip();
            out1(l) = out_0;
        }
        serrures(k) = out1;
    }
    printf("%d", nbPassePartout(n, passepartout, m, serrures));
  }
  
}

