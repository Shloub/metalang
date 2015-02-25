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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray



main =
  do str <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return 12)) <*> getLine))
     let a i =
           if i <= 11
           then do printf "%c" =<< ((readIOA str i) :: IO Char)
                   (a (i + 1))
           else return () in
           (a 0)


