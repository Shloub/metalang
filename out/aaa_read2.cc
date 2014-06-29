#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>


int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

std::vector<int > read_int_line(int n){
  std::vector<int > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    int t = 0;
    scanf("%d ", &t);
    tab.at(i) = t;
  }
  return tab;
}

std::vector<char > read_char_line(int n){
  std::vector<char > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    char t = '_';
    scanf("%c", &t);
    tab.at(i) = t;
  }
  scanf("%*[ \t\r\n]c");
  return tab;
}

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

int main(){
  int len = read_int();
  std::cout << len << "=len\n";
  std::vector<int > tab = read_int_line(len);
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>";
    int a = tab.at(i);
    std::cout << a << " ";
  }
  std::cout << "\n";
  std::vector<int > tab2 = read_int_line(len);
  for (int i_ = 0 ; i_ < len; i_++)
  {
    std::cout << i_ << "==>";
    int b = tab2.at(i_);
    std::cout << b << " ";
  }
  int strlen = read_int();
  std::cout << strlen << "=strlen\n";
  std::vector<char > tab4 = read_char_line(strlen);
  for (int i3 = 0 ; i3 < strlen; i3++)
  {
    char tmpc = tab4.at(i3);
    int c = tmpc;
    std::cout << tmpc << ":" << c << " ";
    if (tmpc != ' ')
      c = ((c - 'a') + 13) % 26 + 'a';
    tab4.at(i3) = c;
  }
  for (int j = 0 ; j < strlen; j++)
  {
    char d = tab4.at(j);
    std::cout << d;
  }
  return 0;
}

