
require "scanf.rb"


def is_number( c )
    return ((c.ord <= '9'.ord) && (c.ord >= '0'.ord));
end


=begin

Notation polonaise inversée

=end

def npi_( str, len )
    stack = [];
    for i in (0 ..  len - 1) do
      stack[i] = 0;
    end
    ptrStack = 0
    ptrStr = 0
    while ptrStr < len do
      if str[ptrStr] == ' ' then
        ptrStr = ptrStr + 1;
      elsif is_number(str[ptrStr]) then
        num = 0
        while str[ptrStr] != ' ' do
          num = num * 10 + str[ptrStr].ord - '0'.ord;
          ptrStr = ptrStr + 1;
        end
        stack[ptrStack] = num;
        ptrStack = ptrStack + 1;
      elsif str[ptrStr] == '+' then
        stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
        ptrStack = ptrStack - 1;
        ptrStr = ptrStr + 1;
      end
    end
    return (stack[0]);
end

len = 0
len=scanf("%d")[0];
scanf("%*\n");
tab = [];
for i in (0 ..  len - 1) do
  tmp = '\000'
  tmp=scanf("%c")[0];
  tab[i] = tmp;
end
result = npi_(tab, len)
printf "%d", result

