using System;

public class aaa_integer
{
  
  public static void Main(String[] args)
  {
    int i = 0;
    i --;
    Console.Write(i + "\n");
    i += 55;
    Console.Write(i + "\n");
    i *= 13;
    Console.Write(i + "\n");
    i /= 2;
    Console.Write(i + "\n");
    i ++;
    Console.Write(i + "\n");
    i /= 3;
    Console.Write(i + "\n");
    i --;
    Console.Write(i + "\n");
    /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
    int a = 117 / 17;
    Console.Write(a + "\n");
    int b = 117 / -17;
    Console.Write(b + "\n");
    int c = -117 / 17;
    Console.Write(c + "\n");
    int d = -117 / -17;
    Console.Write(d + "\n");
    int e = 117 % 17;
    Console.Write(e + "\n");
    int f = 117 % -17;
    Console.Write(f + "\n");
    int g = -117 % 17;
    Console.Write(g + "\n");
    int h = -117 % -17;
    Console.Write(h + "\n");
  }
  
}

