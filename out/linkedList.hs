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

data Intlist = Intlist {
                          _head0 :: IORef Int,
                          _tail0 :: IORef Intlist
                          }
  deriving Eq

cons list i =
  do out0 <- (Intlist <$> (newIORef i) <*> (newIORef list))
     return (out0)
rev2 empty acc torev =
  (if (torev == empty)
  then return (acc)
  else do acc2 <- (Intlist <$> (join (newIORef <$> (readIORef (_head0 torev)))) <*> (newIORef acc))
          (rev2 empty acc =<< (readIORef (_tail0 torev))))
rev empty torev =
  (rev2 empty empty torev)
test empty =
  do let list = empty
     let i = (- 1)
     let a c d =
           (if (c /= 0)
           then do b <- read_int
                   let e = b
                   (if (e /= 0)
                   then do f <- (cons d e)
                           (a e f)
                   else (a e d))
           else return (())) in
           (a i list)
main =
  return (())

