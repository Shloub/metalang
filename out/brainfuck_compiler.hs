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
     let a = 500 + 1
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     writeIOA mem a =<< (((+) 1) <$> (readIOA mem a))
     let b c =
           ifM (((/=) 0) <$> (readIOA mem c))
               (do writeIOA mem c =<< ((-) <$> (readIOA mem c) <*> (return 1))
                   let d = c - 1
                   writeIOA mem d =<< (((+) 1) <$> (readIOA mem d))
                   printf "%c" =<< ((fmap chr (readIOA mem d)) :: IO Char)
                   let e = d + 1
                   b e)
               (return ()) in
           b a


