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
  let d i =
        if i <= 3
        then (( (fmap read . head . reads) <$> getLine :: IO (Int, Int)) >>= (\ (a, b) ->
                                                                               do printf "a = " :: IO ()
                                                                                  printf "%d" (a :: Int) :: IO ()
                                                                                  printf " b = " :: IO ()
                                                                                  printf "%d" (b :: Int) :: IO ()
                                                                                  printf "\n" :: IO ()
                                                                                  (d (i + 1))))
        else do l <- (join (newListArray . (,) 0 . subtract 1 <$> return 10 <*> fmap (map read . words) getLine))
                let c j =
                      if j <= 9
                      then do printf "%d" =<< ((readIOA l j) :: IO Int)
                              printf "\n" :: IO ()
                              (c (j + 1))
                      else return () in
                      (c 0) in
        (d 1)


