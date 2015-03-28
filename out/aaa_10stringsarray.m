#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

@interface toto : NSObject
{
  @public char* s;
  @public int v;
}
@end
@implementation toto 
@end

char* idstring(char* s){
  return s;
}

void printstring(char* s){
  printf("%s\n", idstring(s));
}

void print_toto(toto * t){
  printf("%s = %d\n", t->s, t->v);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j, i;
  char* *tab = malloc( 2 * sizeof(char*));
  for (i = 0 ; i < 2; i++)
    tab[i] = idstring("chaine de test");
  for (j = 0 ; j <= 1; j++)
    printstring(idstring(tab[j]));
  toto * a = [toto alloc];
  a->s="one";
  a->v=1;
  print_toto(a);
  [pool drain];
  return 0;
}


