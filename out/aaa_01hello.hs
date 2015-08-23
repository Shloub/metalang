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
     if 1 + (((1 + 1) * 2 * (3 + 8)) `quot` 4) - (1 - 2) - 3 == 12 && True
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf "\n" :: IO ()
     if (3 * (4 + 5 + 6) * 2 == 45) == False
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf " " :: IO ()
     if (2 == 1) == False
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf " %d%d" ((((4 + 1) `quot` 3) `quot` (2 + 1))::Int) ((((4 * 1) `quot` 3) `quot` (2 * 1))::Int) :: IO()
     if not (not (5 == 0) && not (5 == 4))
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     if (True && not False) && not (True && False)
     then printf "True" :: IO ()
     else printf "False" :: IO ()
     printf "\n" :: IO ()


