require "scanf.rb"
t = [*0..2 - 1].map { |d|
                     out0=scanf("%d")[0]
                     scanf("%*\n")
                     next (out0)
                     }
printf "%d - %d\n", t[0], t[1]

