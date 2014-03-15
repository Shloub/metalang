
require "scanf.rb"

def mod(x, y)
  return x - y * (x.to_f / y).to_i
end


def position_alphabet( c )
    i = c.ord
    if i <= 'Z'.ord && i >= 'A'.ord then
      return (i - 'A'.ord);
    elsif i <= 'z'.ord && i >= 'a'.ord then
      return (i - 'a'.ord);
    else
      return (-1);
    end
end

def of_position_alphabet( c )
    return (c + 'a'.ord);
end

def crypte( taille_cle, cle, taille, message )
    for i in (0 ..  taille - 1) do
      lettre = position_alphabet(message[i])
      if lettre != -1 then
        addon = position_alphabet(cle[mod(i, taille_cle)])
        new_ = mod(addon + lettre, 26)
        message[i] = of_position_alphabet(new_);
      end
    end
end

taille_cle = 0
taille_cle=scanf("%d")[0];
scanf("%*\n");
cle = [];
for index in (0 ..  taille_cle - 1) do
  out_ = '_'
  out_=scanf("%c")[0];
  cle[index] = out_;
end
scanf("%*\n");
taille = 0
taille=scanf("%d")[0];
scanf("%*\n");
message = [];
for index2 in (0 ..  taille - 1) do
  out2 = '_'
  out2=scanf("%c")[0];
  message[index2] = out2;
end
crypte(taille_cle, cle, taille, message);
for i in (0 ..  taille - 1) do
  a = message[i]
  printf "%c", a
end
print "\n";

