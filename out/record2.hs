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

data Toto = Toto {
                    _foo :: IORef Int,
                    _bar :: IORef Int,
                    _blah :: IORef Int
                    }
  deriving Eq

mktoto v1 =
  do t <- (Toto <$> (newIORef v1) <*> (newIORef 0) <*> (newIORef 0))
     return (t)
result t =
  do (join (writeIORef (_blah t) <$> ((+) <$> (readIORef (_blah t)) <*> return (1))))
     ((+) <$> ((+) <$> (readIORef (_foo t)) <*> ((*) <$> (readIORef (_blah t)) <*> (readIORef (_bar t)))) <*> ((*) <$> (readIORef (_bar t)) <*> (readIORef (_foo t))))
main =
  do t <- (mktoto 4)
     b <- read_int
     (writeIORef (_bar t) b)
     skip_whitespaces
     a <- read_int
     (writeIORef (_blah t) a)
     printf "%d" =<< ((result t) :: IO Int)

