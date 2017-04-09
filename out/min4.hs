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
  printf "%d %d %d %d %d %d\n%d %d %d %d %d %d\n%d %d %d %d %d %d\n%d %d %d %d %d %d\n" ((min (min (min 1 2) 3) 4)::Int) ((min (min (min 1 2) 4) 3)::Int) ((min (min (min 1 3) 2) 4)::Int) ((min (min (min 1 3) 4) 2)::Int) ((min (min (min 1 4) 2) 3)::Int) ((min (min (min 1 4) 3) 2)::Int) ((min (min (min 2 1) 3) 4)::Int) ((min (min (min 2 1) 4) 3)::Int) ((min (min (min 2 3) 1) 4)::Int) ((min (min (min 2 3) 4) 1)::Int) ((min (min (min 2 4) 1) 3)::Int) ((min (min (min 2 4) 3) 1)::Int) ((min (min (min 3 1) 2) 4)::Int) ((min (min (min 3 1) 4) 2)::Int) ((min (min (min 3 2) 1) 4)::Int) ((min (min (min 3 2) 4) 1)::Int) ((min (min (min 3 4) 1) 2)::Int) ((min (min (min 3 4) 2) 1)::Int) ((min (min (min 4 1) 2) 3)::Int) ((min (min (min 4 1) 3) 2)::Int) ((min (min (min 4 2) 1) 3)::Int) ((min (min (min 4 2) 3) 1)::Int) ((min (min (min 4 3) 1) 2)::Int) ((min (min (min 4 3) 2) 1)::Int) :: IO()


