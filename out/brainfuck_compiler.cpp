#include <iostream>
#include <vector>
/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/

int main() {
    char input = ' ';
    int current_pos = 500;
    std::vector<int> mem( 1000, 0 );
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    current_pos += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    mem[current_pos] += 1;
    while (mem[current_pos] != 0)
    {
        mem[current_pos] -= 1;
        current_pos -= 1;
        mem[current_pos] += 1;
        std::cout << (char)(mem[current_pos]);
        current_pos += 1;
    }
}

