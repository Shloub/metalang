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
next0 n =
  return (if (n `rem` 2) == 0
          then n `quot` 2
          else 3 * n + 1)

find n m =
  if n == 1
  then return 1
  else if n >= 1000000
       then (((+) 1) <$> (join $ find <$> (next0 n) <*> return m))
       else ifM (((/=) 0) <$> (readIOA m n))
                (readIOA m n)
                (do writeIOA m n =<< (((+) 1) <$> (join $ find <$> (next0 n) <*> return m))
                    readIOA m n)

main =
  do m <- array_init 1000000 (\ j ->
                               return 0)
     let max0 = 0
     let maxi = 0
     let c i d e =
           if i <= 999
           then {- normalement on met 999999 mais ça dépasse les int32... -}
                do n2 <- find i m
                   if n2 > d
                   then do let f = n2
                           let g = i
                           c (i + 1) f g
                   else c (i + 1) d e
           else do printf "%d" (d :: Int) :: IO ()
                   printf "\n" :: IO ()
                   printf "%d" (e :: Int) :: IO ()
                   printf "\n" :: IO () in
           c 1 max0 maxi


