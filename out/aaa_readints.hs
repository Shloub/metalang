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
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
main =
  do len <- (fmap read getLine)
     printf "%d=len\n" (len::Int) :: IO()
     tab1 <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
     let b i =
           if i <= len - 1
           then do printf "%d=>%d\n" (i::Int) =<< ((readIOA tab1 i)::IO Int)
                   b (i + 1)
           else do c <- (fmap read getLine)
                   tab2 <- array_init (c - 1) (\ a ->
                                                 (join (newListArray . (,) 0 . subtract 1 <$> return c <*> fmap (map read . words) getLine)))
                   let d e =
                         if e <= c - 2
                         then let f j =
                                    if j <= c - 1
                                    then do printf "%d " =<< ((join $ readIOA <$> (readIOA tab2 e) <*> return j)::IO Int)
                                            f (j + 1)
                                    else do printf "\n" :: IO ()
                                            d (e + 1) in
                                    f 0
                         else return () in
                         d 0 in
           b 0


