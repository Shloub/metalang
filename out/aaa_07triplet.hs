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
  let f i =
        if i <= 3
        then do d <- (join (newListArray . (,) 0 . subtract 1 <$> return 3 <*> fmap (map read . words) getLine))
                a <- readIOA d 0
                b <- readIOA d 1
                c <- readIOA d 2
                printf "a = " :: IO ()
                printf "%d" (a :: Int) :: IO ()
                printf " b = " :: IO ()
                printf "%d" (b :: Int) :: IO ()
                printf "c =" :: IO ()
                printf "%d" (c :: Int) :: IO ()
                printf "\n" :: IO ()
                f (i + 1)
        else do l <- (join (newListArray . (,) 0 . subtract 1 <$> return 10 <*> fmap (map read . words) getLine))
                let e j =
                      if j <= 9
                      then do printf "%d" =<< (readIOA l j :: IO Int)
                              printf "\n" :: IO ()
                              e (j + 1)
                      else return () in
                      e 0 in
        f 1


