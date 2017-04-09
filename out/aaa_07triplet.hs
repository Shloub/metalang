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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

main :: IO ()
main =
  let e i =
        if i <= 3
        then do d <- (join (newListArray . (,) 0 . subtract 1 <$> return 3 <*> fmap (map read . words) getLine))
                a <- readIOA d 0
                b <- readIOA d 1
                c <- readIOA d 2
                printf "a = %d b = %dc =%d\n" (a::Int) (b::Int) (c::Int) :: IO()
                e (i + 1)
        else do l <- (join (newListArray . (,) 0 . subtract 1 <$> return 10 <*> fmap (map read . words) getLine))
                let f j =
                      if j <= 9
                      then do printf "%d\n" =<< ((readIOA l j)::IO Int)
                              f (j + 1)
                      else return () in
                      f 0 in
        e 1


