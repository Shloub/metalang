#include <iostream>
#include <vector>
struct toto {
  std::string s;
  int v;
};

std::string idstring(std::string s){
  return s;
}

void printstring(std::string s){
  std::cout << idstring(s) << "\n";
}

void print_toto(toto * t){
  std::cout << t->s << " = " << t->v << "\n";
}


int main(){
  std::vector<std::string> *tab = new std::vector<std::string>( 2 );
  for (int i = 0 ; i < 2; i++)
    tab->at(i) = idstring("chaine de test");
  for (int j = 0 ; j <= 1; j ++)
    printstring(idstring(tab->at(j)));
  toto * a = new toto();
  a->s="one";
  a->v=1;
  print_toto(a);
}

