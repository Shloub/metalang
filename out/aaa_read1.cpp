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

int main() {
  std::vector<char> str = getline();
  for (int i = 0; i <= 11; i ++)
    std::cout << str[i];
}

