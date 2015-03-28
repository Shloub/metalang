#include <iostream>
#include <vector>
/*
TODO ajouter un record qui contient des chaines.
*/
std::string idstring(std::string s){
  return s;
}

void printstring(std::string s){
  std::cout << idstring(s) << "\n";
}


int main(){
  std::vector<std::string > *tab = new std::vector<std::string>( 2 );
  for (int i = 0 ; i < 2; i++)
    tab->at(i) = idstring("chaine de test");
  for (int j = 0 ; j <= 1; j ++)
    printstring(idstring(tab->at(j)));
  return 0;
}

