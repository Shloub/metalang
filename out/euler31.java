import java.util.*;

public class euler31
{
  
  static int result(int sum, int[] t, int maxIndex, int[][] cache)
  {
    if (cache[sum][maxIndex] != 0)
        return cache[sum][maxIndex];
    else if (sum == 0 || maxIndex == 0)
        return 1;
    else
    {
        int out0 = 0;
        int div = sum / t[maxIndex];
        for (int i = 0; i <= div; i += 1)
            out0 += result(sum - i * t[maxIndex], t, maxIndex - 1, cache);
        cache[sum][maxIndex] = out0;
        return out0;
    }
  }
  
  
  public static void main(String args[])
  {
    int[] t = new int[8];
    for (int i = 0; i < 8; i += 1)
        t[i] = 0;
    t[0] = 1;
    t[1] = 2;
    t[2] = 5;
    t[3] = 10;
    t[4] = 20;
    t[5] = 50;
    t[6] = 100;
    t[7] = 200;
    int[][] cache = new int[201][];
    for (int j = 0; j < 201; j += 1)
    {
        int[] o = new int[8];
        for (int k = 0; k < 8; k += 1)
            o[k] = 0;
        cache[j] = o;
    }
    System.out.print(result(200, t, 7, cache));
  }
  
}

