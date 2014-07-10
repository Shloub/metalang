#include <iostream>
#include <vector>
std::vector<char> getline(){
  if (std::cin.flags() & std::ios_base::skipws){
    std::cin.ignore();
    std::cin.unsetf(std::ios::skipws);
  }
  std::string line;
  std::getline(std::cin, line);
  std::vector<char> c(line.begin(), line.end());
  return c;
}
int read_int(){
  int out_ = 0;
  std::cin >> out_ >> std::skipws;
  return out_;
}

std::vector<int > read_int_line(int n){
  std::vector<int > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    int t = 0;
    std::cin >> t >> std::skipws;
    tab.at(i) = t;
  }
  return tab;
}

std::vector<char > read_char_line(int n){
  return getline();
}

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

int main(){
  int b = 0;
  std::cin >> b >> std::skipws;
  int a = b;
  int len = a;
  std::cout << len << "=len\n";
  int e = len;
  std::vector<int > f( e );
  for (int g = 0 ; g < e; g++)
  {
    int h = 0;
    std::cin >> h >> std::skipws;
    f.at(g) = h;
  }
  std::vector<int > d = f;
  std::vector<int > tab = d;
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>" << tab.at(i) << " ";
  }
  std::cout << "\n";
  int l = len;
  std::vector<int > m( l );
  for (int o = 0 ; o < l; o++)
  {
    int p = 0;
    std::cin >> p >> std::skipws;
    m.at(o) = p;
  }
  std::vector<int > k = m;
  std::vector<int > tab2 = k;
  for (int i_ = 0 ; i_ < len; i_++)
  {
    std::cout << i_ << "==>" << tab2.at(i_) << " ";
  }
  int r = 0;
  std::cin >> r >> std::skipws;
  int q = r;
  int strlen = q;
  std::cout << strlen << "=strlen\n";
  int u = strlen;
  std::vector<char > s = getline();
  std::vector<char > tab4 = s;
  for (int i3 = 0 ; i3 < strlen; i3++)
  {
    char tmpc = tab4.at(i3);
    int c = tmpc;
    std::cout << tmpc << ":" << c << " ";
    if (tmpc != ' ')
      c = ((c - 'a') + 13) % 26 + 'a';
    tab4.at(i3) = (char)(c);
  }
  for (int j = 0 ; j < strlen; j++)
    std::cout << tab4.at(j);
  return 0;
}

