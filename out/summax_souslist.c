#include <stdio.h>
#include <stdlib.h>


int summax(int* lst, int len) {
    int i;
    int current = 0;
    int max0 = 0;
    for (i = 0; i < len; i++)
    {
        current += lst[i];
        if (current < 0)
            current = 0;
        if (max0 < current)
            max0 = current;
    }
    return max0;
}int main(void) {
     int i;
     int len = 0;
     scanf("%d ", &len);
     int *tab = calloc(len, sizeof(int));
     for (i = 0; i < len; i++)
     {
         int tmp = 0;
         scanf("%d ", &tmp);
         tab[i] = tmp;
     }
     int result = summax(tab, len);
     printf("%d", result);
     return 0;
}


