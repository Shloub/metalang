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
     printf "%d \n%dfoo" (((4 + 6) * 2)::Int) (5::Int) :: IO()
     let b = 1 + (((1 + 1) * 2 * (3 + 8)) `quot` 4) - (1 - 2) - 3 == 12 && True
     if b
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf "\n" :: IO ()
     let c = (3 * (4 + 5 + 6) * 2 == 45) == False
     if c
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf " " :: IO ()
     let d = (2 == 1) == False
     if d
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf " %d%d" ((((4 + 1) `quot` 3) `quot` (2 + 1))::Int) ((((4 * 1) `quot` 3) `quot` (2 * 1))::Int) :: IO()
     let e = not (not (5 == 0) && not (5 == 4))
     if e
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     let f = (True && not False) && not (True && False)
     if f
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf "\n" :: IO ()


