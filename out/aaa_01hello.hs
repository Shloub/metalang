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
  do printf "Hello World" ::IO()
     let a = 5
     printf "%d" (((4 + 6) * 2) :: Int)::IO()
     printf " " ::IO()
     printf "\n" ::IO()
     printf "%d" (a :: Int)::IO()
     printf "foo" ::IO()
     printf "" ::IO()


