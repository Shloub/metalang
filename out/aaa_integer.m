#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i = 0;
  i --;
  printf("%d\n", i);
  i += 55;
  printf("%d\n", i);
  i *= 13;
  printf("%d\n", i);
  i /= 2;
  printf("%d\n", i);
  i ++;
  printf("%d\n", i);
  i /= 3;
  printf("%d\n", i);
  i --;
  printf("%d\n", i);
  /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
  int a = 117 / 17;
  printf("%d\n", a);
  int b = 117 / -17;
  printf("%d\n", b);
  int c = -117 / 17;
  printf("%d\n", c);
  int d = -117 / -17;
  printf("%d\n", d);
  int e = 117 % 17;
  printf("%d\n", e);
  int f = 117 % -17;
  printf("%d\n", f);
  int g = -117 % 17;
  printf("%d\n", g);
  int h = -117 % -17;
  printf("%d\n", h);
  [pool drain];
  return 0;
}


