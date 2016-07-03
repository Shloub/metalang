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

int programme_candidat(std::vector<std::vector<char> *> * tableau, int taille_x, int taille_y) {
    int out0 = 0;
    for (int i = 0; i < taille_y; i += 1)
    {
        for (int j = 0; j < taille_x; j += 1)
        {
            out0 += (int)(tableau->at(i)->at(j)) * (i + j * 2);
            std::cout << tableau->at(i)->at(j);
        }
        std::cout << "--\n";
    }
    return out0;
}


int main() {
    int taille_y, taille_x;
    std::cin >> taille_x >> taille_y;
    std::vector<std::vector<char> *> *a = new std::vector<std::vector<char> *>( taille_y );
    for (int b = 0; b < taille_y; b += 1)
        a->at(b) = getline();
    std::vector<std::vector<char> *> * tableau = a;
    std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
}

