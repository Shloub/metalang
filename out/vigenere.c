#include <stdio.h>
#include <stdlib.h>


int position_alphabet(char c) {
  int i = (int)(c);
  if (i <= (int)('Z') && i >= (int)('A'))
    return i - (int)('A');
  else if (i <= (int)('z') && i >= (int)('a'))
    return i - (int)('a');
  else
    return -1;
}


char of_position_alphabet(int c) {
  return (char)(c + (int)('a'));
}


void crypte(int taille_cle, char* cle, int taille, char* message) {
  int i;
  for (i = 0; i < taille; i++)
  {
    int lettre = position_alphabet(message[i]);
    if (lettre != -1)
    {
      int addon = position_alphabet(cle[i % taille_cle]);
      int new0 = (addon + lettre) % 26;
      message[i] = of_position_alphabet(new0);
    }
  }
}

int main(void) {
  int i, index2, taille, index, taille_cle;
  char out2, out0;
  scanf("%d ", &taille_cle);
  char *cle = calloc( taille_cle , sizeof(char));
  for (index = 0; index < taille_cle; index++)
  {
    scanf("%c", &out0);
    cle[index] = out0;
  }
  scanf(" %d ", &taille);
  char *message = calloc( taille , sizeof(char));
  for (index2 = 0; index2 < taille; index2++)
  {
    scanf("%c", &out2);
    message[index2] = out2;
  }
  crypte(taille_cle, cle, taille, message);
  for (i = 0; i < taille; i++)
    printf("%c", message[i]);
  printf("\n");
  return 0;
}


