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
  do len <- (fmap read getLine)
     printf "%d\n" (len::Int) :: IO()


