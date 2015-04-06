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
eratostene t max0 =
  let a i b =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let c = b + i
                     if (max0 `quot` i) > i
                     then do let j = i * i
                             let d e =
                                   if e < max0 && e > 0
                                   then do writeIOA t e 0
                                           let f = e + i
                                           d f
                                   else a (i + 1) c in
                                   d j
                     else a (i + 1) c)
                 (a (i + 1) b)
        else return b in
        a 2 0

main =
  {- normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages -}
  do t <- array_init 100000 (\ i ->
                               return i)
     writeIOA t 1 0
     printf "%d\n" =<< ((eratostene t 100000)::IO Int)


