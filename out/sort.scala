object sort
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
  
  def copytab(tab : Array[Int], len : Int): Array[Int] = {
    var o :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
    
        o(i) = tab(i);
    return o;
  }
  
  def bubblesort(tab : Array[Int], len : Int){
    for (i <- 0 to len - 1)
    
        for (j <- i + 1 to len - 1)
        
            if (tab(i) > tab(j))
            {
                var tmp: Int = tab(i);
                tab(i) = tab(j);
                tab(j) = tmp;
            }
  }
  
  def qsort0(tab : Array[Int], len : Int, _i : Int, _j : Int){
    var i = _i;
    var j = _j;
    if (i < j)
    {
        var i0: Int = i;
        var j0: Int = j;
        /* pivot : tab[0] */
        while (i != j)
            if (tab(i) > tab(j))
                if (i == j - 1)
                {
                    /* on inverse simplement*/
                    var tmp: Int = tab(i);
                    tab(i) = tab(j);
                    tab(j) = tmp;
                    i = i + 1;
                }
                else
                {
                    /* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] */
                    var tmp: Int = tab(i);
                    tab(i) = tab(j);
                    tab(j) = tab(i + 1);
                    tab(i + 1) = tmp;
                    i = i + 1;
                }
            else
                j = j - 1;
        qsort0(tab, len, i0, i - 1);
        qsort0(tab, len, i + 1, j0);
    }
  }
  
  
  def main(args : Array[String])
  {
    var len: Int = 2;
    len = read_int();
    skip();
    var tab :Array[Int] = new Array[Int](len);
    for (i_0 <- 0 to len - 1)
    
    {
        var tmp: Int = 0;
        tmp = read_int();
        skip();
        tab(i_0) = tmp;
    }
    var tab2: Array[Int] = copytab(tab, len);
    bubblesort(tab2, len);
    for (i <- 0 to len - 1)
    
        printf("%d ", tab2(i));
    printf("\n");
    var tab3: Array[Int] = copytab(tab, len);
    qsort0(tab3, len, 0, len - 1);
    for (i <- 0 to len - 1)
    
        printf("%d ", tab3(i));
    printf("\n");
  }
  
}

