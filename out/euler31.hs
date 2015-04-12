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
result sum t maxIndex cache =
  ifM (((/=) 0) <$> (join $ readIOA <$> (readIOA cache sum) <*> return maxIndex))
      (join $ readIOA <$> (readIOA cache sum) <*> return maxIndex)
      (if sum == 0 || maxIndex == 0
       then return 1
       else do div <- ((quot sum) <$> (readIOA t maxIndex))
               let a i b =
                     if i <= div
                     then do c <- (((+) b) <$> (join $ result <$> (((-) sum) <$> (((*) i) <$> (readIOA t maxIndex))) <*> return t <*> return (maxIndex - 1) <*> return cache))
                             a (i + 1) c
                     else do join $ writeIOA <$> (readIOA cache sum) <*> return maxIndex <*> return b
                             return b in
                     a 0 0)

main =
  do t <- array_init 8 (\ i ->
                          return 0)
     writeIOA t 0 1
     writeIOA t 1 2
     writeIOA t 2 5
     writeIOA t 3 10
     writeIOA t 4 20
     writeIOA t 5 50
     writeIOA t 6 100
     writeIOA t 7 200
     cache <- array_init 201 (\ j ->
                                array_init 8 (\ k ->
                                                return 0))
     printf "%d" =<< (result 200 t 7 cache :: IO Int)


