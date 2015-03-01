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
  let a i e =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let f = e + i
                     if (max0 `quot` i) > i
                     then do let j = i * i
                             let b g =
                                   if g < max0 && g > 0
                                   then do writeIOA t g 0
                                           let h = g + i
                                           b h
                                   else a (i + 1) f in
                                   b j
                     else a (i + 1) f)
                 (a (i + 1) e)
        else return e in
        a 2 0

main =
  {- normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages -}
  do t <- array_init 100000 (\ i ->
                               return i)
     writeIOA t 1 0
     printf "%d\n" =<< ((eratostene t 100000)::IO Int)


