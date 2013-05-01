#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>

bool is_number(char c){
  return c <= '9' && c >= '0';
}

/*
Notation polonaise inversée
*/
int npi_(std::vector<char >& str, int len){
  std::vector<int > stack( len );
  for (int i = 0 ; i < len; i++)
  {
    stack.at(i) = 0;
  }
  int ptrStack = 0;
  int ptrStr = 0;
  while (ptrStr < len)
  {
    if (str.at(ptrStr) == ' ')
    {
      ptrStr = ptrStr + 1;
    }
    else if (is_number(str.at(ptrStr)))
    {
      int num = 0;
      while (str.at(ptrStr) != ' ')
      {
        num = num * 10 + str.at(ptrStr) - '0';
        ptrStr = ptrStr + 1;
      }
      stack.at(ptrStack) = num;
      ptrStack = ptrStack + 1;
    }
    else if (str.at(ptrStr) == '+')
    {
      stack.at(ptrStack - 2) = stack.at(ptrStack - 2) + stack.at(ptrStack - 1);
      ptrStack = ptrStack - 1;
      ptrStr = ptrStr + 1;
    }
  }
  return stack.at(0);
}


int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  std::vector<char > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    char tmp = '\000';
    scanf("%c", &tmp);
    tab.at(i) = tmp;
  }
  int result = npi_(tab, len);
  printf("%d", result);
  return 0;
}

