using System;

public class brainfuck_compiler
{
  
  /*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
  
  public static void Main(String[] args)
  {
    char input = (char)32;
    int current_pos = 500;
    int g = 1000;
    int[] mem = new int[g];
    for (int i = 0 ; i < g; i++)
      mem[i] = 0;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    current_pos ++;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    while (mem[current_pos] != 0)
    {
      mem[current_pos] = mem[current_pos] - 1;
      current_pos --;
      mem[current_pos] = mem[current_pos] + 1;
      char h = (char)(mem[current_pos]);
      Console.Write(h);
      current_pos ++;
    }
  }
  
}

