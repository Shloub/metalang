import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

main :: IO ()
main =
  do printf "%d\n" ((3 + 3 + 5 + 4 + 4)::Int) :: IO()
     let one_to_nine = 3 + 3 + 5 + 4 + 4 + 3 + 5 + 5 + 4
     printf "%d\n" (one_to_nine::Int) :: IO()
     let one_to_ten = one_to_nine + 3
     let one_to_twenty = one_to_ten + 6 + 6 + 8 + 8 + 7 + 7 + 9 + 8 + 8 + 6
     let one_to_thirty = one_to_twenty + 6 * 9 + one_to_nine + 6
     let one_to_forty = one_to_thirty + 6 * 9 + one_to_nine + 5
     let one_to_fifty = one_to_forty + 5 * 9 + one_to_nine + 5
     let one_to_sixty = one_to_fifty + 5 * 9 + one_to_nine + 5
     let one_to_seventy = one_to_sixty + 5 * 9 + one_to_nine + 7
     let one_to_eighty = one_to_seventy + 7 * 9 + one_to_nine + 6
     let one_to_ninety = one_to_eighty + 6 * 9 + one_to_nine + 6
     let one_to_ninety_nine = one_to_ninety + 6 * 9 + one_to_nine
     printf "%d\n%d\n" (one_to_ninety_nine::Int) ((100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 3 + 8)::Int) :: IO()


