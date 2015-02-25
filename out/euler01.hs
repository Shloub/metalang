import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()



main =
  do let sum = 0
     let a i b =
           if i <= 999
           then if (i `rem` 3) == 0 || (i `rem` 5) == 0
                then do let c = b + i
                        (a (i + 1) c)
                else (a (i + 1) b)
           else do printf "%d" (b :: Int) :: IO ()
                   printf "\n" :: IO () in
           (a 0 sum)


