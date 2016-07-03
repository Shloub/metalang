#include <iostream>
#include <vector>
/*
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
*/

int main(void) {
    int j = 0;
    j = 0;
    std::cout << j << "\n";
    j = 1;
    std::cout << j << "\n";
    j = 2;
    std::cout << j << "\n";
    j = 3;
    std::cout << j << "\n";
    j = 4;
    std::cout << j << "\n";
    return 0;
}

