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
pathfind_aux cache tab len pos =
  if pos >= len - 1
  then return 0
  else ifM (((/=) (- 1)) <$> (readIOA cache pos))
           (readIOA cache pos)
           (do writeIOA cache pos (len * 2)
               posval <- pathfind_aux cache tab len =<< (readIOA tab pos)
               oneval <- pathfind_aux cache tab len (pos + 1)
               let a = if posval < oneval
                       then 1 + posval
                       else 1 + oneval
               writeIOA cache pos a
               return a)

pathfind tab len =
  do cache <- array_init len (\ i ->
                                return (- 1))
     pathfind_aux cache tab len 0

main =
  do b <- read_int
     skip_whitespaces
     tab <- array_init b (\ i ->
                            do c <- read_int
                               skip_whitespaces
                               return c)
     result <- pathfind tab b
     printf "%d" (result :: Int) :: IO ()


