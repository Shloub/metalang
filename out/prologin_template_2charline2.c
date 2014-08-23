#include<stdio.h>
#include<stdlib.h>

int programme_candidat(char* tableau1, int taille1, char* tableau2, int taille2){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i < taille1; i++)
    {
      out_ += (int)(tableau1[i]) * i;
      printf("%c", tableau1[i]);
    }
  }
  printf("--\n");
  {
    int j;
    for (j = 0 ; j < taille2; j++)
    {
      out_ += (int)(tableau2[j]) * j * 100;
      printf("%c", tableau2[j]);
    }
  }
  printf("--\n");
  return out_;
}

int main(void){
  int b = 0;
  scanf("%d ", &b);
  int taille1 = b;
  int d = 0;
  scanf("%d ", &d);
  int taille2 = d;
  char *f = malloc( taille1 * sizeof(char));
  {
    int g;
    for (g = 0 ; g < taille1; g++)
    {
      char h = '_';
      scanf("%c", &h);
      f[g] = h;
    }
  }
  scanf(" ");
  char* tableau1 = f;
  char *l = malloc( taille2 * sizeof(char));
  {
    int m;
    for (m = 0 ; m < taille2; m++)
    {
      char o = '_';
      scanf("%c", &o);
      l[m] = o;
    }
  }
  scanf(" ");
  char* tableau2 = l;
  printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  return 0;
}


