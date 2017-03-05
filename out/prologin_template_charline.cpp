#include <iostream>
#include <vector>
std::vector<char> getline() {
    if (std::cin.flags() & std::ios_base::skipws) {
        char c = std::cin.peek();
        if (c == '\n' || c == ' ') std::cin.ignore();
        std::cin.unsetf(std::ios::skipws);
    }
    std::string line;
    std::getline(std::cin, line);
    std::vector<char> c(line.begin(), line.end());
    std::cin >> std::skipws;
    return c;
}

int programme_candidat(std::vector<char>& tableau, int taille) {
    int out0 = 0;
    for (int i = 0; i < taille; i++)
    {
        out0 += (int)(tableau[i]) * i;
        std::cout << tableau[i];
    }
    std::cout << "--\n";
    return out0;
}

int main() {
    int taille;
    std::cin >> taille;
    std::vector<char> tableau = getline();
    std::cout << programme_candidat(tableau, taille) << "\n";
}

