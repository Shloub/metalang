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
skip_whitespaces :: IO ()
skip_whitespaces =
  ifM isEOF
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do getChar
              skip_whitespaces
           else return ())
read_int_a :: Int -> IO Int
read_int_a b =
  ifM isEOF
      (return b)
      (do c <- hLookAhead stdin
          if isNumber c then
           do getChar
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      (* sign) <$> read_int_a 0
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
go0 tab a b =
  do let m = (a + b) `quot` 2
     if a == m
     then ifM (((==) m) <$> (readIOA tab a))
              (return b)
              (return a)
     else do let i = a
             let j = b
             let c k l =
                   if k < l
                   then do e <- readIOA tab k
                           if e < m
                           then do let n = k + 1
                                   c n l
                           else do let o = l - 1
                                   writeIOA tab k =<< (readIOA tab o)
                                   writeIOA tab o e
                                   c k o
                   else if k < m
                        then go0 tab a m
                        else go0 tab m b in
                   c i j

plus_petit0 tab len =
  go0 tab 0 len

main =
  do let len = 0
     h <- read_int
     let p = h
     skip_whitespaces
     tab <- array_init p (\ i ->
                            do let tmp = 0
                               g <- read_int
                               let q = g
                               skip_whitespaces
                               return q)
     printf "%d" =<< (plus_petit0 tab p :: IO Int)


