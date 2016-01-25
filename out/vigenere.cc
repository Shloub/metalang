#include <iostream>
#include <vector>
int position_alphabet(char c){
  int i = (int)(c);
  if (i <= (int)('Z') && i >= (int)('A'))
    return i - (int)('A');
  else if (i <= (int)('z') && i >= (int)('a'))
    return i - (int)('a');
  else
    return -1;
}

char of_position_alphabet(int c){
  return (char)(c + (int)('a'));
}

void crypte(int taille_cle, std::vector<char> * cle, int taille, std::vector<char> * message){
  for (int i = 0 ; i < taille; i++)
  {
    int lettre = position_alphabet(message->at(i));
    if (lettre != -1)
    {
      int addon = position_alphabet(cle->at(i % taille_cle));
      int new0 = (addon + lettre) % 26;
      message->at(i) = of_position_alphabet(new0);
    }
  }
}


int main(){
  int taille, taille_cle;
  char out2, out0;
  std::cin >> taille_cle >> std::skipws;
  std::vector<char> *cle = new std::vector<char>( taille_cle );
  for (int index = 0 ; index < taille_cle; index++)
  {
    std::cin >> out0 >> std::noskipws;
    cle->at(index) = out0;
  }
  std::cin >> std::skipws >> taille;
  std::vector<char> *message = new std::vector<char>( taille );
  for (int index2 = 0 ; index2 < taille; index2++)
  {
    std::cin >> out2 >> std::noskipws;
    message->at(index2) = out2;
  }
  crypte(taille_cle, cle, taille, message);
  for (int i = 0 ; i < taille; i++)
    std::cout << message->at(i);
  std::cout << "\n";
  return 0;
}

