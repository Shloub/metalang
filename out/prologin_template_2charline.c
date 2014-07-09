#include<stdio.h>
#include<stdlib.h>

int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

char* read_char_line(int n){
  char *tab = malloc( n * sizeof(char));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      char t = '_';
      scanf("%c", &t);
      tab[i] = t;
    }
  }
  scanf(" ");
  return tab;
}

int programme_candidat(char* tableau1, int taille1, char* tableau2, int taille2){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i < taille1; i++)
    {
      out_ += tableau1[i] * i;
      printf("%c", tableau1[i]);
    }
  }
  printf("--\n");
  {
    int j;
    for (j = 0 ; j < taille2; j++)
    {
      out_ += tableau2[j] * j * 100;
      printf("%c", tableau2[j]);
    }
  }
  printf("--\n");
  return out_;
}

int main(void){
  int taille1 = read_int();
  char* tableau1 = read_char_line(taille1);
  int taille2 = read_int();
  char* tableau2 = read_char_line(taille2);
  printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  return 0;
}


