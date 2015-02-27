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
                                                                                                                                 


main =
  do let input = ' '
     let current_pos = 500
     mem <- array_init 1000 (\ i ->
                              return 0)
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     writeIOA mem current_pos =<< (((+) 1) <$> (readIOA mem current_pos))
     let d = current_pos + 1
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
     let c e =
           ifM (((/=) 0) <$> (readIOA mem e))
               (do writeIOA mem e =<< ((-) <$> (readIOA mem e) <*> (return 1))
                   let f = e - 1
                   writeIOA mem f =<< (((+) 1) <$> (readIOA mem f))
                   printf "%c" =<< (((fmap chr (readIOA mem f))) :: IO Char)
                   let g = f + 1
                   c g)
               (return ()) in
           c d


