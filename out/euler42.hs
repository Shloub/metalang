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

is_triangular n =
  {-
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   -}
  do a <- ((fmap (floor . sqrt . fromIntegral) (return ((n * 2)))))
     return (((a * (a + 1)) == (n * 2)))
score () =
  do skip_whitespaces
     len <- read_int
     skip_whitespaces
     let sum = 0
     let e = 1
     let f = len
     let d i o =
           (if (i <= f)
           then hGetChar stdin >>= ((\ c ->
                                      do p <- (((+) o) <$> ((+) <$> ((-) <$> ((fmap ord (return (c)))) <*> ((fmap ord (return ('A'))))) <*> return (1)))
                                         {-		print c print " " print sum print " " -}
                                         (d (i + 1) p)))
           else do let b () = return (())
                   ifM ((is_triangular o))
                       (return (1))
                       (return (0))) in
           (d e sum)
main =
  do let l = 1
     let m = 55
     let k i =
           (if (i <= m)
           then do ifM ((is_triangular i))
                       (do printf "%d" (i :: Int)::IO()
                           printf " " ::IO())
                       (return (()))
                   (k (i + 1))
           else do printf "\n" ::IO()
                   let sum = 0
                   n <- read_int
                   let h = 1
                   let j = n
                   let g q r =
                         (if (q <= j)
                         then do s <- (((+) r) <$> (score ()))
                                 (g (q + 1) s)
                         else do printf "%d" (r :: Int)::IO()
                                 printf "\n" ::IO()) in
                         (g h sum)) in
           (k l)

