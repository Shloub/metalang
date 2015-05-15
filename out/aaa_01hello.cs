using System;

public class aaa_01hello
{
  
  public static void Main(String[] args)
  {
    Console.Write("Hello World");
    int a = 5;
    Console.Write("" + ((4 + 6) * 2) + " \n" + a + "foo");
    bool b = 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && true;
    if (b)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write("\n");
    bool c = (3 * (4 + 5 + 6) * 2 == 45) == false;
    if (c)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write(" ");
    bool d = (2 == 1) == false;
    if (d)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write(" " + ((4 + 1) / 3 / (2 + 1)) + (4 * 1 / 3 / 2 * 1));
    bool e = !(!(a == 0) && !(a == 4));
    if (e)
      Console.Write("True");
    else
      Console.Write("False");
    bool f = true && !false && !(true && false);
    if (f)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write("\n");
  }
  
}

