#import <Foundation/Foundation.h>
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
      char a = tableau1[i];
      printf("%c", a);
    }
  }
  printf("--\n");
  {
    int j;
    for (j = 0 ; j < taille2; j++)
    {
      out_ += tableau2[j] * j * 100;
      char b = tableau2[j];
      printf("%c", b);
    }
  }
  printf("--\n");
  return out_;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int taille1 = read_int();
  int taille2 = read_int();
  char* tableau1 = read_char_line(taille1);
  char* tableau2 = read_char_line(taille2);
  int c = programme_candidat(tableau1, taille1, tableau2, taille2);
  printf("%d\n", c);
  [pool drain];
  return 0;
}


