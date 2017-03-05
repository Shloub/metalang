#include <stdio.h>
#include <stdlib.h>


int pathfind_aux(int* cache, int* tab, int len, int pos) {
    if (pos >= len - 1)
        return 0;
    else if (cache[pos] != -1)
        return cache[pos];
    else
    {
        cache[pos] = len * 2;
        int posval = pathfind_aux(cache, tab, len, tab[pos]);
        int oneval = pathfind_aux(cache, tab, len, pos + 1);
        int out0 = 0;
        if (posval < oneval)
            out0 = 1 + posval;
        else
            out0 = 1 + oneval;
        cache[pos] = out0;
        return out0;
    }
}

int pathfind(int* tab, int len) {
    int i;
    int *cache = calloc(len, sizeof(int));
    for (i = 0; i < len; i++)
        cache[i] = -1;
    return pathfind_aux(cache, tab, len, 0);
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
     int result = pathfind(tab, len);
     printf("%d", result);
     return 0;
}


