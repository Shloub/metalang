require "scanf.rb"
def nbPassePartout( n, passepartout, m, serrures )
  max_ancient = 0
  max_recent = 0
  for i in (0 ..  m - 1) do
      if serrures[i][0] == -1 && serrures[i][1] > max_ancient then
          max_ancient = serrures[i][1]
      end
      if serrures[i][0] == 1 && serrures[i][1] > max_recent then
          max_recent = serrures[i][1]
      end
      end
      max_ancient_pp = 0
      max_recent_pp = 0
      for i in (0 ..  n - 1) do
          pp = passepartout[i]
          if pp[0] >= max_ancient && pp[1] >= max_recent then
              return 1
          end
          max_ancient_pp = [max_ancient_pp, pp[0]].max
          max_recent_pp = [max_recent_pp, pp[1]].max
          end
          if max_ancient_pp >= max_ancient && max_recent_pp >= max_recent then
              return 2
          else 
              return 0
          end
      end
      n = scanf("%d")[0]
      scanf("%*\n")
      passepartout = [*0..n-1].map { |i|
        
        out0 = [*0..2-1].map { |j|
          
          out01 = scanf("%d")[0]
          scanf("%*\n")
          next out01
          }
        next out0
        }
      m = scanf("%d")[0]
      scanf("%*\n")
      serrures = [*0..m-1].map { |k|
        
        out1 = [*0..2-1].map { |l|
          
          out_ = scanf("%d")[0]
          scanf("%*\n")
          next out_
          }
        next out1
        }
      printf "%d", nbPassePartout(n, passepartout, m, serrures)
      