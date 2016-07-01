using System;

public class aaa_01hello
{
  
  public static void Main(String[] args)
  {
    Console.Write("Hello World");
    int a = 5;
    Console.Write(((4 + 6) * 2) + " \n" + a + "foo");
    if (1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && true)
        Console.Write("True");
    else
        Console.Write("False");
    Console.Write("\n");
    if ((3 * (4 + 5 + 6) * 2 == 45) == false)
        Console.Write("True");
    else
        Console.Write("False");
    Console.Write(" ");
    if ((2 == 1) == false)
        Console.Write("True");
    else
        Console.Write("False");
    Console.Write(" " + ((4 + 1) / 3 / (2 + 1)) + (4 * 1 / 3 / 2 * 1));
    if (!(!(a == 0) && !(a == 4)))
        Console.Write("True");
    else
        Console.Write("False");
    if (true && !false && !(true && false))
        Console.Write("True");
    else
        Console.Write("False");
    Console.Write("\n");
  }
  
}

