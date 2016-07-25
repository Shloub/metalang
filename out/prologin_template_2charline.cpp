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

int programme_candidat(std::vector<char>& tableau1, int taille1, std::vector<char>& tableau2, int taille2) {
    int out0 = 0;
    for (int i = 0; i < taille1; i++)
    {
        out0 += (int)(tableau1[i]) * i;
        std::cout << tableau1[i];
    }
    std::cout << "--\n";
    for (int j = 0; j < taille2; j++)
    {
        out0 += (int)(tableau2[j]) * j * 100;
        std::cout << tableau2[j];
    }
    std::cout << "--\n";
    return out0;
}


int main() {
    int taille2, taille1;
    std::cin >> taille1;
    std::vector<char> tableau1 = getline();
    std::cin >> taille2;
    std::vector<char> tableau2 = getline();
    std::cout << programme_candidat(tableau1, taille1, tableau2, taille2) << "\n";
}

