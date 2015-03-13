import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
min2_ a b =
  return (if a < b
          then a
          else b)



main =
  do x <- (fmap read getLine)
     y <- (fmap read getLine)
     tab <- array_init y (\ d ->
                            (join (newListArray . (,) 0 . subtract 1 <$> return x <*> fmap (map read . words) getLine)))
     let i ix =
           if ix <= x - 1
           then let j iy =
                      if iy <= y - 1
                      then ifM (((==) 1) <$> (join $ readIOA <$> (readIOA tab iy) <*> return ix))
                               (do join $ writeIOA <$> (readIOA tab iy) <*> return ix <*> (((+) 1) <$> (join $ min2_ <$> (join $ min2_ <$> (join $ readIOA <$> (readIOA tab iy) <*> return (ix - 1)) <*> (join $ readIOA <$> (readIOA tab (iy - 1)) <*> return ix)) <*> (join $ readIOA <$> (readIOA tab (iy - 1)) <*> return (ix - 1))))
                                   j (iy + 1))
                               (j (iy + 1))
                      else i (ix + 1) in
                      j 1
           else let g jy =
                      if jy <= y - 1
                      then let h jx =
                                 if jx <= x - 1
                                 then do printf "%d " =<< ((join $ readIOA <$> (readIOA tab jy) <*> return jx)::IO Int)
                                         h (jx + 1)
                                 else do printf "\n" :: IO ()
                                         g (jy + 1) in
                                 h 0
                      else return () in
                      g 0 in
           i 1


