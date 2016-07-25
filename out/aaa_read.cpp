#include <iostream>
#include <vector>
/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

int main() {
    int strlen, tmpi2, tmpi1, len;
    char tmpc;
    std::cin >> len;
    std::cout << len << "=len\n";
    len *= 2;
    std::cout << "len*2=" << len << "\n";
    len /= 2;
    std::vector<int> tab( len );
    for (int i = 0; i < len; i++)
    {
        std::cin >> tmpi1;
        std::cout << i << "=>" << tmpi1 << " ";
        tab[i] = tmpi1;
    }
    std::cout << "\n";
    std::vector<int> tab2( len );
    for (int i_ = 0; i_ < len; i_++)
    {
        std::cin >> tmpi2;
        std::cout << i_ << "==>" << tmpi2 << " ";
        tab2[i_] = tmpi2;
    }
    std::cin >> strlen;
    std::cout << strlen << "=strlen\n";
    std::vector<char> tab4( strlen );
    for (int toto = 0; toto < strlen; toto++)
    {
        std::cin >> tmpc >> std::noskipws;
        int c = (int)(tmpc);
        std::cout << tmpc << ":" << c << " ";
        if (tmpc != ' ')
            c = (c - (int)('a') + 13) % 26 + (int)('a');
        tab4[toto] = (char)(c);
    }
    for (int j = 0; j < strlen; j++)
        std::cout << tab4[j];
}

