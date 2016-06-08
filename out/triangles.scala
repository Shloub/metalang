object triangles
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
  
  /* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
*/
  def find0(len : Int, tab : Array[Array[Int]], cache : Array[Array[Int]], x : Int, y : Int): Int = {
    /*
	Cette fonction est récursive
	*/
    if (y == len - 1)
        return tab(y)(x);
    else
        if (x > y)
            return -10000;
        else
            if (cache(y)(x) != 0)
                return cache(y)(x);
    var result: Int = 0;
    var out0: Int = find0(len, tab, cache, x, y + 1);
    var out1: Int = find0(len, tab, cache, x + 1, y + 1);
    if (out0 > out1)
        result = out0 + tab(y)(x);
    else
        result = out1 + tab(y)(x);
    cache(y)(x) = result;
    return result;
  }
  
  def find(len : Int, tab : Array[Array[Int]]): Int = {
    var tab2 :Array[Array[Int]] = new Array[Array[Int]](len);
    for (i <- 0 to len - 1)
    {
        var tab3 :Array[Int] = new Array[Int](i + 1);
        for (j <- 0 to i + 1 - 1)
            tab3(j) = 0;
        tab2(i) = tab3;
    }
    return find0(len, tab, tab2, 0, 0);
  }
  
  
  def main(args : Array[String])
  {
    var len: Int = 0;
    len = read_int();
    skip();
    var tab :Array[Array[Int]] = new Array[Array[Int]](len);
    for (i <- 0 to len - 1)
    {
        var tab2 :Array[Int] = new Array[Int](i + 1);
        for (j <- 0 to i + 1 - 1)
        {
            var tmp: Int = 0;
            tmp = read_int();
            skip();
            tab2(j) = tmp;
        }
        tab(i) = tab2;
    }
    printf("%d\n", find(len, tab));
    for (k <- 0 to len - 1)
    {
        for (l <- 0 to k)
            printf("%d ", tab(k)(l));
        printf("\n");
    }
  }
  
}

