#include <stdio.h>
#include <stdlib.h>


int min2_(int a, int b) {
    if (a < b)
      return a;
    else
      return b;
}

int main(void) {
    printf("%d %d %d %d %d %d\n%d %d %d %d %d %d\n%d %d %d %d %d %d\n%d %d %d %d %d %d\n", min2_(min2_(min2_(1, 2), 3), 4), min2_(min2_(min2_(1, 2), 4), 3), min2_(min2_(min2_(1, 3), 2), 4), min2_(min2_(min2_(1, 3), 4), 2), min2_(min2_(min2_(1, 4), 2), 3), min2_(min2_(min2_(1, 4), 3), 2), min2_(min2_(min2_(2, 1), 3), 4), min2_(min2_(min2_(2, 1), 4), 3), min2_(min2_(min2_(2, 3), 1), 4), min2_(min2_(min2_(2, 3), 4), 1), min2_(min2_(min2_(2, 4), 1), 3), min2_(min2_(min2_(2, 4), 3), 1), min2_(min2_(min2_(3, 1), 2), 4), min2_(min2_(min2_(3, 1), 4), 2), min2_(min2_(min2_(3, 2), 1), 4), min2_(min2_(min2_(3, 2), 4), 1), min2_(min2_(min2_(3, 4), 1), 2), min2_(min2_(min2_(3, 4), 2), 1), min2_(min2_(min2_(4, 1), 2), 3), min2_(min2_(min2_(4, 1), 3), 2), min2_(min2_(min2_(4, 2), 1), 3), min2_(min2_(min2_(4, 2), 3), 1), min2_(min2_(min2_(4, 3), 1), 2), min2_(min2_(min2_(4, 3), 2), 1));
    return 0;
}


