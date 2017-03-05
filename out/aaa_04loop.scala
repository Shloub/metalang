object aaa_04loop
{
  
  def h(i : Int): Boolean = {
    /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
    var j: Int = i - 2;
    while (j <= i + 2)
    {
        if (i % j == 5)
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

