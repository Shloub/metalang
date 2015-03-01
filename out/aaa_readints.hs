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
     let f i =
           if i <= len - 1
           then do printf "%d=>%d\n" (i::Int) =<< ((readIOA tab1 i)::IO Int)
                   f (i + 1)
           else do g <- (fmap read getLine)
                   tab2 <- array_init (g - 1) (\ a ->
                                                 (join (newListArray . (,) 0 . subtract 1 <$> return g <*> fmap (map read . words) getLine)))
                   let d h =
                         if h <= g - 2
                         then let e j =
                                    if j <= g - 1
                                    then do printf "%d " =<< ((join $ readIOA <$> (readIOA tab2 h) <*> return j)::IO Int)
                                            e (j + 1)
                                    else do printf "\n" :: IO ()
                                            d (h + 1) in
                                    e 0
                         else return () in
                         d 0 in
           f 0


