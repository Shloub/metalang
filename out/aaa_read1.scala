object aaa_read1
{
  
  
  def main(args : Array[String])
  {
    var str: Array[Char] = readLine().toCharArray();
    for (i <- 0 to 11)
      printf("%c", str(i));
  }
  
}

