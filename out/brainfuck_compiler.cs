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
    int[] mem = new int[1000];
    for (int i = 0; i < 1000; i++)
        mem[i] = 0;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    current_pos++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    mem[current_pos]++;
    while (mem[current_pos] != 0)
    {
        mem[current_pos]--;
        current_pos--;
        mem[current_pos]++;
        Console.Write((char)(mem[current_pos]));
        current_pos++;
    }
  }
  
}

