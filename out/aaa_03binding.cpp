#include <iostream>
#include <vector>

int g(int i) {
    int j = i * 4;
    if (j % 2 == 1)
        return 0;
    return j;
}


void h(int i) {
    std::cout << i << "\n";
}


int main(void) {
    h(14);
    int a = 4;
    int b = 5;
    std::cout << a + b;
    /* main */
    h(15);
    a = 2;
    b = 1;
    std::cout << a + b;
    return 0;
}

