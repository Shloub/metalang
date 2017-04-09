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
  let c i =
        if i <= 3
        then ( (fmap read . head . reads) <$> getLine :: IO (Int, Int)) >>= (\ (a, b) ->
                                                                              do printf "a = %d b = %d\n" (a::Int) (b::Int) :: IO()
                                                                                 c (i + 1))
        else do l <- (join (newListArray . (,) 0 . subtract 1 <$> return 10 <*> fmap (map read . words) getLine))
                let d j =
                      if j <= 9
                      then do printf "%d\n" =<< ((readIOA l j)::IO Int)
                              d (j + 1)
                      else return () in
                      d 0 in
        c 1


