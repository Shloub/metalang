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

main =
  do mem <- array_init 1000 (\ i ->
                               return 0)
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     writeIOA mem 500 =<< (((+) 1) <$> (readIOA mem 500))
     let d = 500 + 1
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
                   printf "%c" =<< ((fmap chr (readIOA mem f)) :: IO Char)
                   let g = f + 1
                   c g)
               (return ()) in
           c d


