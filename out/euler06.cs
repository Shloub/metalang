using System;

public class euler06
{
  
  public static void Main(String[] args)
  {
    int lim = 100;
    int sum = lim * (lim + 1) / 2;
    int carressum = sum * sum;
    int sumcarres = lim * (lim + 1) * (2 * lim + 1) / 6;
    Console.Write(carressum - sumcarres);
  }
  
}

