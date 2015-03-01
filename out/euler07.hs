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
divisible n t size =
  do let c = size - 1
     let b i =
           if i <= c
           then ifM (((==) 0) <$> ((rem n) <$> (readIOA t i)))
                    (return True)
                    (b (i + 1))
           else return False in
           b 0

find n t used nth =
  let a f g =
        if g /= nth
        then ifM (divisible f t g)
                 (do let h = f + 1
                     a h g)
                 (do writeIOA t g f
                     let j = f + 1
                     let k = g + 1
                     a j k)
        else readIOA t (g - 1) in
        a n used

main =
  do let n = 10001
     t <- array_init n (\ i ->
                          return 2)
     printf "%d\n" =<< ((find 3 t 1 n)::IO Int) :: IO()


