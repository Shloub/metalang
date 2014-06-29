#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>


int main(){
  int i = 0;
  i --;
  std::cout << i << "\n";
  i += 55;
  std::cout << i << "\n";
  i *= 13;
  std::cout << i << "\n";
  i /= 2;
  std::cout << i << "\n";
  i ++;
  std::cout << i << "\n";
  i /= 3;
  std::cout << i << "\n";
  i --;
  std::cout << i << "\n";
  /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
  int a = 117 / 17;
  std::cout << a << "\n";
  int b = 117 / -17;
  std::cout << b << "\n";
  int c = -117 / 17;
  std::cout << c << "\n";
  int d = -117 / -17;
  std::cout << d << "\n";
  int e = 117 % 17;
  std::cout << e << "\n";
  int f = 117 % -17;
  std::cout << f << "\n";
  int g = -117 % 17;
  std::cout << g << "\n";
  int h = -117 % -17;
  std::cout << h << "\n";
  return 0;
}

