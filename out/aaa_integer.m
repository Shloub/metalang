#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i = 0;
  i--;
  printf("%d\n", i);
  i += 55;
  printf("%d\n", i);
  i *= 13;
  printf("%d\n", i);
  i /= 2;
  printf("%d\n", i);
  i++;
  printf("%d\n", i);
  i /= 3;
  printf("%d\n", i);
  i--;
  printf("%d\n", i);
  /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
  printf("%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n", 117 / 17, 117 / -17, -117 / 17, -117 / -17, 117 % 17, 117 % -17, -117 % 17, -117 % -17);
  [pool drain];
  return 0;
}


