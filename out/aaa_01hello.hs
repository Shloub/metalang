import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e

main :: IO ()
main =
  do printf "Hello World" :: IO ()
     let a = 5
     printf "%d \n%dfoo" (((4 + 6) * 2)::Int) (a::Int) :: IO()
     let b = 1 + (((1 + 1) * 2 * (3 + 8)) `quot` 4) - (1 - 2) - 3 == 12 && True
     if b
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf "\n" :: IO ()
     let c = (3 * (4 + 5 + 6) * 2 == 45) == False
     if c
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf "%d%d" ((((4 + 1) `quot` 3) `quot` (2 + 1))::Int) ((((4 * 1) `quot` 3) `quot` (2 * 1))::Int) :: IO()
     let d = not (not (a == 0) && not (a == 4))
     if d
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     let e = (True && not False) && not (True && False)
     if e
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf "\n" :: IO ()


