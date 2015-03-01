import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

main :: IO ()
g i =
  let j = i * 4
          in return (if (j `rem` 2) == 1
                     then 0
                     else j)

h i =
  printf "%d\n" (i::Int) :: IO()

main =
  do h 14
     printf "%d" (4 + 5 :: Int) :: IO ()
     {- main -}
     do h 15
        printf "%d" (2 + 1 :: Int) :: IO ()


