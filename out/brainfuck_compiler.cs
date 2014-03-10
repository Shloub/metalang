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
    int a = 1000;
    int[] mem_ = new int[a];
    for (int i = 0 ; i < a; i++)
      mem_[i] = 0;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    current_pos ++;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    while (mem_[current_pos] != 0)
    {
      mem_[current_pos] = mem_[current_pos] - 1;
      current_pos --;
      mem_[current_pos] = mem_[current_pos] + 1;
      char b = (char)(mem_[current_pos]);
      Console.Write(b);
      current_pos ++;
    }
  }
  
}

