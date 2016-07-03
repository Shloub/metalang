using System;

public class aaa_integer
{
  
  public static void Main(String[] args)
  {
    int i = 0;
    i--;
    Console.Write(i + "\n");
    i += 55;
    Console.Write(i + "\n");
    i *= 13;
    Console.Write(i + "\n");
    i /= 2;
    Console.Write(i + "\n");
    i++;
    Console.Write(i + "\n");
    i /= 3;
    Console.Write(i + "\n");
    i--;
    Console.Write(i + "\n");
    /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
    Console.Write((117 / 17) + "\n" + (117 / -17) + "\n" + (-117 / 17) + "\n" + (-117 / -17) + "\n" + (117 % 17) + "\n" + (117 % -17) + "\n" + (-117 % 17) + "\n" + (-117 % -17) + "\n");
  }
  
}

