#include <stdio.h>
#include <stdlib.h>


int montagnes0(int* tab, int len) {
    int max0 = 1;
    int j = 1;
    int i = len - 2;
    while (i >= 0)
    {
        int x = tab[i];
        while (j >= 0 && x > tab[len - j])
            j--;
        j++;
        tab[len - j] = x;
        if (j > max0)
            max0 = j;
        i--;
    }
    return max0;
}

int main(void) {
    int i;
    int len = 0;
    scanf("%d ", &len);
    int *tab = calloc(len, sizeof(int));
    for (i = 0; i < len; i++)
    {
        int x = 0;
        scanf("%d ", &x);
        tab[i] = x;
    }
    printf("%d", montagnes0(tab, len));
    return 0;
}


