object euler11
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
def read_char() : Char = {
  if (buffer != null && buffer == "") buffer = readLine();
  var c = buffer.charAt(0);
  buffer = buffer.substring(1);
  return c;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}

  def max2_(a : Int, b : Int): Int = {
    if (a > b)
      return a;
    else
      return b;
  }
  
  def find(n : Int, m : Array[Array[Int]], x : Int, y : Int, dx : Int, dy : Int): Int = {
    if (x < 0 || x == 20 || y < 0 || y == 20)
      return -1;
    else if (n == 0)
      return 1;
    else
      return m(y)(x) * find(n - 1, m, x + dx, y + dy, dx, dy);
  }
  
  class Tuple_int_int(_tuple_int_int_field_0: Int, _tuple_int_int_field_1: Int){
    var tuple_int_int_field_0: Int=_tuple_int_int_field_0;
    var tuple_int_int_field_1: Int=_tuple_int_int_field_1;
  }
  
  
  def main(args : Array[String])
  {
    var directions :Array[Tuple_int_int] = new Array[Tuple_int_int](8);
    for (i <- 0 to 8 - 1)
      if (i == 0)
    {
      var c = new Tuple_int_int(0, 1);
      directions(i) = c;
    }
    else if (i == 1)
    {
      var d = new Tuple_int_int(1, 0);
      directions(i) = d;
    }
    else if (i == 2)
    {
      var e = new Tuple_int_int(0, -1);
      directions(i) = e;
    }
    else if (i == 3)
    {
      var f = new Tuple_int_int(-1, 0);
      directions(i) = f;
    }
    else if (i == 4)
    {
      var g = new Tuple_int_int(1, 1);
      directions(i) = g;
    }
    else if (i == 5)
    {
      var h = new Tuple_int_int(1, -1);
      directions(i) = h;
    }
    else if (i == 6)
    {
      var k = new Tuple_int_int(-1, 1);
      directions(i) = k;
    }
    else
    {
      var l = new Tuple_int_int(-1, -1);
      directions(i) = l;
    }
    var max0: Int = 0;
    var m :Array[Array[Int]] = new Array[Array[Int]](20);
    for (o <- 0 to 20 - 1)
    {
      var p :Array[Int] = new Array[Int](20);
      for (q <- 0 to 20 - 1)
      {
        p(q) = read_int()
        skip();
      }
      m(o) = p;
    }
    for (j <- 0 to 7)
    {
      var r: Tuple_int_int = directions(j);
      var dx: Int = r.tuple_int_int_field_0;
      var dy: Int = r.tuple_int_int_field_1;
      for (x <- 0 to 19)
        for (y <- 0 to 19)
          max0 = max2_(max0, find(4, m, x, y, dx, dy));
    }
    printf("%d\n", max0);
  }
  
}

