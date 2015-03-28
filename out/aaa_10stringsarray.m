#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
TODO ajouter un record qui contient des chaines.
*/
char* idstring(char* s){
  return s;
}

void printstring(char* s){
  printf("%s\n", idstring(s));
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j, i;
  char* *tab = malloc( 2 * sizeof(char*));
  for (i = 0 ; i < 2; i++)
    tab[i] = idstring("chaine de test");
  for (j = 0 ; j <= 1; j++)
    printstring(idstring(tab[j]));
  [pool drain];
  return 0;
}


