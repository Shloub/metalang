#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>


int main(void){
  char input = ' ';
  int current_pos = 500;
  int e = 1000;
  std::vector<int > mem( e );
  for (int i = 0 ; i < e; i++)
  {
    mem.at(i) = 0;
  }
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  current_pos = current_pos + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  while (mem.at(current_pos) != 0)
  {
    mem.at(current_pos) = mem.at(current_pos) - 1;
    current_pos = current_pos - 1;
    mem.at(current_pos) = mem.at(current_pos) + 1;
    char f = mem.at(current_pos);
    printf("%c", f);
    current_pos = current_pos + 1;
  }
  return 0;
}

