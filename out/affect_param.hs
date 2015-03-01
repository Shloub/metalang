import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

main :: IO ()
foo a =
  return ()

main =
  do foo 0
     printf "%d\n" (0::Int) :: IO()


