object pathfinding0
{
  
  def min2_0(a : Int, b : Int): Int = {
    if (a < b)
        return a;
    else
        return b;
  }
  
  def pathfind_aux(cache : Array[Array[Int]], tab : Array[Array[Char]], x : Int, y : Int, posX : Int, posY : Int): Int = {
    if (posX == x - 1 && posY == y - 1)
        return 0;
    else
        if (posX < 0 || posY < 0 || posX >= x || posY >= y)
            return x * y * 10;
        else
            if (tab(posY)(posX) == '#')
                return x * y * 10;
            else
                if (cache(posY)(posX) != -1)
                    return cache(posY)(posX);
                else
                {
                    cache(posY)(posX) = x * y * 10;
                    var val1: Int = pathfind_aux(cache, tab, x, y, posX + 1, posY);
                    var val2: Int = pathfind_aux(cache, tab, x, y, posX - 1, posY);
                    var val3: Int = pathfind_aux(cache, tab, x, y, posX, posY - 1);
                    var val4: Int = pathfind_aux(cache, tab, x, y, posX, posY + 1);
                    var out0: Int = 1 + min2_0(min2_0(min2_0(val1, val2), val3), val4);
                    cache(posY)(posX) = out0;
                    return out0;
                }
  }
  
  def pathfind(tab : Array[Array[Char]], x : Int, y : Int): Int = {
    var cache :Array[Array[Int]] = new Array[Array[Int]](y);
    for (i <- 0 to y - 1)
    {
        var tmp :Array[Int] = new Array[Int](x);
        for (j <- 0 to x - 1)
        {
            printf("%c", tab(i)(j));
            tmp(j) = -1;
        }
        printf("\n");
        cache(i) = tmp;
    }
    return pathfind_aux(cache, tab, x, y, 0, 0);
  }
  
  
  def main(args : Array[String])
  {
    var x: Int = readInt().toInt;
    var y: Int = readInt().toInt;
    printf("%d %d\n", x, y);
    var e :Array[Array[Char]] = new Array[Array[Char]](y);
    for (f <- 0 to y - 1)
        e(f) = readLine().toCharArray();
    var tab: Array[Array[Char]] = e;
    var result: Int = pathfind(tab, x, y);
    printf("%d", result);
  }
  
}

