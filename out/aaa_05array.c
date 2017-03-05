#include <stdio.h>
#include <stdlib.h>


int* id(int* b) {
    return b;
}

void g(int* t, int index) {
    t[index] = 0;
}int main(void) {
     int i;
     int j = 0;
     int *a = calloc(5, sizeof(int));
     for (i = 0; i < 5; i++)
     {
         printf("%d", i);
         j += i;
         a[i] = i % 2 == 0;
     }
     printf("%d ", j);
     if (a[0])
         printf("True");
     else
         printf("False");
     printf("\n");
     g(id(a), 0);
     if (a[0])
         printf("True");
     else
         printf("False");
     printf("\n");
     return 0;
}


