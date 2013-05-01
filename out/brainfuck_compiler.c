#include<stdio.h>
#include<stdlib.h>


int main(void){
  char input = ' ';
  int current_pos = 500;
  int a = 1000;
  int *mem = malloc( a * sizeof(int));
  
  {
    int i;
    for (i = 0 ; i < a; i++)
      mem[i] = 0;
  }
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
  current_pos = current_pos + 1;
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
    current_pos = current_pos - 1;
    mem[current_pos] = mem[current_pos] + 1;
    char b = mem[current_pos];
    printf("%c", b);
    current_pos = current_pos + 1;
  }
  return 0;
}


