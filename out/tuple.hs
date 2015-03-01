import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

main :: IO ()
f tuple0 =
  (\ (a, b) ->
    return (a + 1, b + 1)) tuple0

main =
  do t <- f (0, 1)
     (\ (a, b) ->
       printf "%d -- %d--\n" (a::Int) (b::Int) :: IO()) t


