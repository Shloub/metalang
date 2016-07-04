#include <stdio.h>
#include <stdlib.h>


int is_pair(int i) {
    int j = 1;
    if (i < 10)
    {
        j = 2;
        if (i == 0)
        {
            j = 4;
            return 1;
        }
        j = 3;
        if (i == 2)
        {
            j = 4;
            return 1;
        }
        j = 5;
    }
    j = 6;
    if (i < 20)
    {
        if (i == 22)
            j = 0;
        j = 8;
    }
    return i % 2 == 0;
}

int main(void) {
    
    return 0;
}


