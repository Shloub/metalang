import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b


main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())

read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)

score () =
  do skip_whitespaces
     len <- read_int
     skip_whitespaces
     let sum = 0
     let b = 1
     let d = len
     let a i h =
           (if (i <= d)
           then hGetChar stdin >>= ((\ c ->
                                      do j <- (((+) h) <$> ((+) <$> ((-) <$> ((fmap ord (return (c)))) <*> ((fmap ord (return ('A'))))) <*> return (1)))
                                         {-		print c print " " print sum print " " -}
                                         (a (i + 1) j)))
           else return (h)) in
           (a b sum)
main =
  do let sum = 0
     n <- read_int
     let f = 1
     let g = n
     let e i k =
           (if (i <= g)
           then do l <- (((+) k) <$> (((*) i) <$> (score ())))
                   (e (i + 1) l)
           else do printf "%d" (k :: Int)::IO()
                   printf "\n" ::IO()) in
           (e f sum)

