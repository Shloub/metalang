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
  printf "%d %d %d %d %d %d\n" ((min (min 2 3) 4)::Int) ((min (min 2 4) 3)::Int) ((min (min 3 2) 4)::Int) ((min (min 3 4) 2)::Int) ((min (min 4 2) 3)::Int) ((min (min 4 3) 2)::Int) :: IO()


