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
  do let sum = (100 * (100 + 1)) `quot` 2
     let carressum = sum * sum
     let sumcarres = (100 * (100 + 1) * (2 * 100 + 1)) `quot` 6
     printf "%d" (carressum - sumcarres :: Int) :: IO ()


