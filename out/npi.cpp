#include <iostream>
#include <vector>
bool is_number(char c){
  return (int)(c) <= (int)('9') && (int)(c) >= (int)('0');
}

/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
int npi0(std::vector<char>& str, int len){
  std::vector<int> stack(len, 0);
  int ptrStack = 0;
  int ptrStr = 0;
  while (ptrStr < len)
    if (str[ptrStr] == ' ')
    ptrStr++;
  else if (is_number(str[ptrStr]))
  {
    int num = 0;
    while (str[ptrStr] != ' ')
    {
      num = num * 10 + (int)(str[ptrStr]) - (int)('0');
      ptrStr++;
    }
    stack[ptrStack] = num;
    ptrStack++;
  }
  else if (str[ptrStr] == '+')
  {
    stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
    ptrStack --;
    ptrStr++;
  }
  return stack[0];
}


int main(){
  int len = 0;
  std::cin >> len >> std::skipws;
  std::vector<char> tab(len);
  for (int i = 0 ; i < len; i++)
  {
    char tmp = '\u0000';
    std::cin >> tmp >> std::noskipws;
    tab[i] = tmp;
  }
  int result = npi0(tab, len);
  std::cout << result;
}

