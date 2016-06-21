require "scanf.rb"
n = 10
# normalement on doit mettre 20 mais là on se tape un overflow 

n += 1
tab = [*0..n-1].map { |i|
  
  tab2 = [*0..n-1].map { |j|
    
    next 0
    }
  next tab2
  }
for l in (0 ..  n - 1) do
    tab[n - 1][l] = 1
    tab[l][n - 1] = 1
    end
    for o in (2 ..  n) do
        r = n - o
        for p in (2 ..  n) do
            q = n - p
            tab[r][q] = tab[r + 1][q] + tab[r][q + 1]
            end
            end
            for m in (0 ..  n - 1) do
                for k in (0 ..  n - 1) do
                    printf "%d ", tab[m][k]
                    end
                    print "\n"
                    end
                    printf "%d\n", tab[0][0]
                    
                    