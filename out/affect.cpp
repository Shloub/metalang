#include <iostream>
#include <vector>
/*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/
typedef struct toto {
  int foo;
    int bar;
    int blah;
} toto;


toto mktoto(int v1) {
    toto t;
        t.foo = v1;
        t.bar = v1;
        t.blah = v1;;
    return t;
}


toto mktoto2(int v1) {
    toto t;
        t.foo = v1 + 3;
        t.bar = v1 + 2;
        t.blah = v1 + 1;;
    return t;
}


int result(toto& t_, toto& t2_) {
    toto t = t_;
    toto t2 = t2_;
    toto t3;
        t3.foo = 0;
        t3.bar = 0;
        t3.blah = 0;;
    t3 = t2;
    t = t2;
    t2 = t3;
    t.blah += 1;
    int len = 1;
    std::vector<int> cache0( len );
    for (int i = 0; i < len; i += 1)
        cache0[i] = -i;
    std::vector<int> cache1( len );
    for (int j = 0; j < len; j += 1)
        cache1[j] = j;
    std::vector<int> cache2 = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t.foo + t.blah * t.bar + t.bar * t.foo;
}


int main(void) {
    toto t = mktoto(4);
    toto t2 = mktoto(5);
    std::cin >> t.bar >> t.blah >> t2.bar >> t2.blah >> std::noskipws;
    std::cout << result(t, t2) << t.blah;
    return 0;
}

