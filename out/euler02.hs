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
  do let a = 1
     let b = 2
     let sum = 0
     let d e f g =
           if e < 4000000
           then do let h = if (e `rem` 2) == 0
                           then let i = g + e
                                        in i
                           else g
                   let c = e
                   let j = f
                   let k = f + c
                   d j k h
           else do printf "%d" (g :: Int) :: IO ()
                   printf "\n" :: IO () in
           d a b sum


