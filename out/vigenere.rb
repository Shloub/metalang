require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def position_alphabet( c )
    i = c.ord
    if i <= "Z".ord && i >= "A".ord then
      return (i - "A".ord)
    elsif i <= "z".ord && i >= "a".ord then
      return (i - "a".ord)
    else
      return (-1)
    end
end

def of_position_alphabet( c )
    return (c + "a".ord)
end

def crypte( taille_cle, cle, taille, message )
    for i in (0 ..  taille - 1) do
      lettre = position_alphabet(message[i])
      if lettre != -1 then
        addon = position_alphabet(cle[mod(i, taille_cle)])
        new0 = mod(addon + lettre, 26)
        message[i] = of_position_alphabet(new0)
      end
    end
end

taille_cle=scanf("%d")[0]
scanf("%*\n")
cle = [*0..taille_cle - 1].map { |index|
  out0=scanf("%c")[0]
  next (out0)
  }
scanf("%*\n")
taille=scanf("%d")[0]
scanf("%*\n")
message = [*0..taille - 1].map { |index2|
  out2=scanf("%c")[0]
  next (out2)
  }
crypte(taille_cle, cle, taille, message)
for i in (0 ..  taille - 1) do
  printf "%c", message[i]
end
print "\n"

