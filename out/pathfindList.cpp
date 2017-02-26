#include <iostream>
#include <vector>

int pathfind_aux(std::vector<int>& cache, std::vector<int>& tab, int len, int pos) {
    if (pos >= len - 1)
        return 0;
    else if (cache[pos] != -1)
        return cache[pos];
    else
    {
        cache[pos] = len * 2;
        int posval = pathfind_aux(cache, tab, len, tab[pos]);
        int oneval = pathfind_aux(cache, tab, len, pos + 1);
        int out0 = 0;
        if (posval < oneval)
            out0 = 1 + posval;
        else
            out0 = 1 + oneval;
        cache[pos] = out0;
        return out0;
    }
}


int pathfind(std::vector<int>& tab, int len) {
    std::vector<int> cache( len );
    for (int i = 0; i < len; i++)
        cache[i] = -1;
    return pathfind_aux(cache, tab, len, 0);
}

int main() {
    int len = 0;
    std::cin >> len;
    std::vector<int> tab( len );
    for (int i = 0; i < len; i++)
    {
        int tmp = 0;
        std::cin >> tmp;
        tab[i] = tmp;
    }
    int result = pathfind(tab, len);
    std::cout << result;
}

