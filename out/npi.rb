require "scanf.rb"
def is_number( c )
    return (c.ord <= "9".ord && c.ord >= "0".ord)
end


=begin

Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI

=end

def npi0( str, len )
    stack = [*0..len - 1].map { |i|
      next (0)
      }
    ptrStack = 0
    ptrStr = 0
    while ptrStr < len do
      if str[ptrStr] == " " then
        ptrStr += 1
      elsif is_number(str[ptrStr]) then
        num = 0
        while str[ptrStr] != " " do
          num = num * 10 + str[ptrStr].ord - "0".ord
          ptrStr += 1
        end
        stack[ptrStack] = num
        ptrStack += 1
      elsif str[ptrStr] == "+" then
        stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1]
        ptrStack -= 1
        ptrStr += 1
      end
    end
    return (stack[0])
end

len = 0
len=scanf("%d")[0]
scanf("%*\n")
tab = [*0..len - 1].map { |i|
  tmp = "\u0000"
  tmp=scanf("%c")[0]
  next (tmp)
  }
result = npi0(tab, len)
printf "%d", result

