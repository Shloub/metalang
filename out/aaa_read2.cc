#include <iostream>
#include <vector>
std::vector<char> *getline() {
    if (std::cin.flags() & std::ios_base::skipws) {
        char c = std::cin.peek();
        if (c == '\n' || c == ' ') std::cin.ignore();
        std::cin.unsetf(std::ios::skipws);
    }
    std::string line;
    std::getline(std::cin, line);
    std::vector<char> *c = new std::vector<char>(line.begin(), line.end());
    std::cin >> std::skipws;
    return c;
}



/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
int main() {
    int strlen, len;
    std::cin >> len;
    std::cout << len << "=len\n";
    std::vector<int> *tab = new std::vector<int>( len );
    for (int a = 0; a < len; a++)
    {
        std::cin >> tab->at(a);
    }
    for (int i = 0; i < len; i++)
        std::cout << i << "=>" << tab->at(i) << " ";
    std::cout << "\n";
    std::vector<int> *tab2 = new std::vector<int>( len );
    for (int b = 0; b < len; b++)
    {
        std::cin >> tab2->at(b);
    }
    for (int i_ = 0; i_ < len; i_++)
        std::cout << i_ << "==>" << tab2->at(i_) << " ";
    std::cin >> strlen;
    std::cout << strlen << "=strlen\n";
    std::vector<char> * tab4 = getline();
    for (int i3 = 0; i3 < strlen; i3++)
    {
        char tmpc = tab4->at(i3);
        int c = (int)(tmpc);
        std::cout << tmpc << ":" << c << " ";
        if (tmpc != ' ')
            c = (c - (int)('a') + 13) % 26 + (int)('a');
        tab4->at(i3) = (char)(c);
    }
    for (int j = 0; j < strlen; j++)
        std::cout << tab4->at(j);
}

