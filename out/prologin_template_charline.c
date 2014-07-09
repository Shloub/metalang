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

int programme_candidat(char* tableau, int taille){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i < taille; i++)
    {
      out_ += tableau[i] * i;
      printf("%c", tableau[i]);
    }
  }
  printf("--\n");
  return out_;
}

int main(void){
  int taille = read_int();
  char* tableau = read_char_line(taille);
  printf("%d\n", programme_candidat(tableau, taille));
  return 0;
}


