#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>


int position_alphabet(char c){
  int i = c;
  if (i <= 'Z' && i >= 'A')
    return i - 'A';
  else if (i <= 'z' && i >= 'a')
    return i - 'a';
  else
    return -1;
}

char of_position_alphabet(int c){
  return c + 'a';
}

void crypte(int taille_cle, std::vector<char >& cle, int taille, std::vector<char >& message){
  for (int i = 0 ; i < taille; i++)
  {
    int lettre = position_alphabet(message.at(i));
    if (lettre != -1)
    {
      int addon = position_alphabet(cle.at(i % taille_cle));
      int new_ = (addon + lettre) % 26;
      message.at(i) = of_position_alphabet(new_);
    }
  }
}


int main(){
  int taille_cle = 0;
  scanf("%d ", &taille_cle);
  std::vector<char > cle( taille_cle );
  for (int index = 0 ; index < taille_cle; index++)
  {
    char out_ = '_';
    scanf("%c", &out_);
    cle.at(index) = out_;
  }
  scanf("%*[ \t\r\n]c");
  int taille = 0;
  scanf("%d ", &taille);
  std::vector<char > message( taille );
  for (int index2 = 0 ; index2 < taille; index2++)
  {
    char out2 = '_';
    scanf("%c", &out2);
    message.at(index2) = out2;
  }
  crypte(taille_cle, cle, taille, message);
  for (int i = 0 ; i < taille; i++)
  {
    char a = message.at(i);
    std::cout << a;
  }
  std::cout << "\n";
  return 0;
}

