#include <iostream>
#include <vector>

int main() {
    int i = 0;
    i --;
    std::cout << i << "\n";
    i += 55;
    std::cout << i << "\n";
    i *= 13;
    std::cout << i << "\n";
    i /= 2;
    std::cout << i << "\n";
    i++;
    std::cout << i << "\n";
    i /= 3;
    std::cout << i << "\n";
    i --;
    std::cout << i << "\n";
    /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
    std::cout << 117 / 17 << "\n" << 117 / -17 << "\n" << -117 / 17 << "\n" << -117 / -17 << "\n" << 117 % 17 << "\n" << 117 % -17 << "\n" << -117 % 17 << "\n" << -117 % -17 << "\n";
}

