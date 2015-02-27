import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False
(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f =
  do li <- g 0
     newListArray (0, len - 1) li
  where g i =
           if i == len
           then return []
           else do item <- f i
                   li <- g (i+1)
                   return (item:li)
                                                                                                                                 

result sum t maxIndex cache =
  ifM (((/=) 0) <$> (join $ readIOA <$> (readIOA cache sum) <*> return maxIndex))
      (join $ readIOA <$> (readIOA cache sum) <*> return maxIndex)
      (if sum == 0 || maxIndex == 0
       then return 1
       else do let out0 = 0
               div <- ((quot sum) <$> (readIOA t maxIndex))
               let a i h =
                     if i <= div
                     then do l <- (((+) h) <$> (join $ result <$> (((-) sum) <$> (((*) i) <$> (readIOA t maxIndex))) <*> return t <*> return (maxIndex - 1) <*> return cache))
                             a (i + 1) l
                     else do join $ writeIOA <$> (readIOA cache sum) <*> return maxIndex <*> return h
                             return h in
                     a 0 out0)

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
                               do o <- array_init 8 (\ k ->
                                                      return 0)
                                  return o)
     printf "%d" =<< (result 200 t 7 cache :: IO Int)


