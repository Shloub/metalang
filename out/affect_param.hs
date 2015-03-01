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
  let b = 4
          in return ()

main =
  do let a = 0
     foo a
     printf "%d\n" (a::Int) :: IO()


