#include<stdio.h>
#include<stdlib.h>


int main(void){
  /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
  {
    int a;
    for (a = 1 ; a <= 1000; a++)
      {
      int b;
      for (b = a + 1 ; b <= 1000; b++)
      {
        int c = 1000 - a - b;
        int a2b2 = a * a + b * b;
        int cc = c * c;
        if (cc == a2b2 && c > a)
        {
          printf("%d\n%d\n%d\n", a, b, c);
          int d = a * b * c;
          printf("%d\n", d);
        }
      }
    }
  }
  return 0;
}


