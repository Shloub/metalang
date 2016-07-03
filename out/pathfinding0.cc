#include <iostream>
#include <vector>
#include <algorithm>
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

int pathfind_aux(std::vector<std::vector<int> *> * cache, std::vector<std::vector<char> *> * tab, int x, int y, int posX, int posY) {
    if (posX == x - 1 && posY == y - 1)
        return 0;
    else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
        return x * y * 10;
    else if (tab->at(posY)->at(posX) == '#')
        return x * y * 10;
    else if (cache->at(posY)->at(posX) != -1)
        return cache->at(posY)->at(posX);
    else
    {
        cache->at(posY)->at(posX) = x * y * 10;
        int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
        int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
        int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
        int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
        int out0 = 1 + std::min({val1, val2, val3, val4});
        cache->at(posY)->at(posX) = out0;
        return out0;
    }
}


int pathfind(std::vector<std::vector<char> *> * tab, int x, int y) {
    std::vector<std::vector<int> *> *cache = new std::vector<std::vector<int> *>( y );
    for (int i = 0; i < y; i++)
    {
        std::vector<int> *tmp = new std::vector<int>( x );
        for (int j = 0; j < x; j++)
        {
            std::cout << tab->at(i)->at(j);
            tmp->at(j) = -1;
        }
        std::cout << "\n";
        cache->at(i) = tmp;
    }
    return pathfind_aux(cache, tab, x, y, 0, 0);
}


int main() {
    int y, x;
    std::cin >> x >> y;
    std::cout << x << " " << y << "\n";
    std::vector<std::vector<char> *> *e = new std::vector<std::vector<char> *>( y );
    for (int f = 0; f < y; f++)
        e->at(f) = getline();
    std::vector<std::vector<char> *> * tab = e;
    int result = pathfind(tab, x, y);
    std::cout << result;
}

