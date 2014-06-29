#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>



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

void crypte(int taille_cle, char* cle, int taille, char* message){
  {
    int i;
    for (i = 0 ; i < taille; i++)
    {
      int lettre = position_alphabet(message[i]);
      if (lettre != -1)
      {
        int addon = position_alphabet(cle[i % taille_cle]);
        int new_ = (addon + lettre) % 26;
        message[i] = of_position_alphabet(new_);
      }
    }
  }
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int taille_cle = 0;
  scanf("%d ", &taille_cle);
  char *cle = malloc( taille_cle * sizeof(char));
  {
    int index;
    for (index = 0 ; index < taille_cle; index++)
    {
      char out_ = '_';
      scanf("%c", &out_);
      cle[index] = out_;
    }
  }
  scanf("%*[ \t\r\n]c");
  int taille = 0;
  scanf("%d ", &taille);
  char *message = malloc( taille * sizeof(char));
  {
    int index2;
    for (index2 = 0 ; index2 < taille; index2++)
    {
      char out2 = '_';
      scanf("%c", &out2);
      message[index2] = out2;
    }
  }
  crypte(taille_cle, cle, taille, message);
  {
    int i;
    for (i = 0 ; i < taille; i++)
    {
      char a = message[i];
      printf("%c", a);
    }
  }
  printf("\n");
  [pool drain];
  return 0;
}


