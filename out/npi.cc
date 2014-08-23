#include <iostream>
#include <vector>
bool is_number(char c){
  return (int)(c) <= (int)('9') && (int)(c) >= (int)('0');
}

/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
int npi_(std::vector<char> * str, int len){
  std::vector<int > *stack = new std::vector<int>( len );
  for (int i = 0 ; i < len; i++)
    stack->at(i) = 0;
  int ptrStack = 0;
  int ptrStr = 0;
  while (ptrStr < len)
    if (str->at(ptrStr) == ' ')
    ptrStr ++;
  else if (is_number(str->at(ptrStr)))
  {
    int num = 0;
    while (str->at(ptrStr) != ' ')
    {
      num = num * 10 + (int)(str->at(ptrStr)) - (int)('0');
      ptrStr ++;
    }
    stack->at(ptrStack) = num;
    ptrStack ++;
  }
  else if (str->at(ptrStr) == '+')
  {
    stack->at(ptrStack - 2) = stack->at(ptrStack - 2) + stack->at(ptrStack - 1);
    ptrStack --;
    ptrStr ++;
  }
  return stack->at(0);
}


int main(){
  int len = 0;
  std::cin >> len >> std::skipws;
  std::vector<char > *tab = new std::vector<char>( len );
  for (int i = 0 ; i < len; i++)
  {
    char tmp = '\000';
    std::cin >> tmp >> std::noskipws;
    tab->at(i) = tmp;
  }
  int result = npi_(tab, len);
  std::cout << result;
  return 0;
}

