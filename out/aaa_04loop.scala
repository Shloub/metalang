object aaa_04loop
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

  def h(i : Int): Boolean = {
    /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
    var j: Int = i - 2;
    while (j <= i + 2)
    {
      if ((i % j) == 5)
        return true;
      j = j + 1;
    }
    return false;
  }
  
  
  def main(args : Array[String])
  {
    var j: Int = 0;
    for (k <- 0 to 10)
    {
      j = j + k;
      printf("%d\n", j);
    }
    var i: Int = 4;
    while (i < 10)
    {
      printf("%d", i);
      i = i + 1;
      j = j + i;
    }
    printf("%d%dFIN TEST\n", j, i);
  }
  
}

