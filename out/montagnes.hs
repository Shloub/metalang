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
montagnes0 tab len =
  do let i = len - 2
     let a b c d =
           if b >= 0
           then do x <- readIOA tab b
                   let e f =
                         ifM ((return (f >= 0)) <&&> (((>) x) <$> (readIOA tab (len - f))))
                             (do let g = f - 1
                                 e g)
                             (do let h = f + 1
                                 writeIOA tab (len - h) x
                                 let k = if h > d
                                         then h
                                         else d
                                 let l = b - 1
                                 a l h k) in
                         e c
           else return d in
           a i 1 1

main =
  do m <- read_int
     skip_whitespaces
     tab <- array_init m (\ i ->
                            do n <- read_int
                               skip_whitespaces
                               return n)
     printf "%d" =<< (montagnes0 tab m :: IO Int)


