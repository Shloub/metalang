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
  do let max0 = 1
     let j = 1
     let i = len - 2
     let a g h k =
           if g >= 0
           then do x <- readIOA tab g
                   let b l =
                         ifM ((return (l >= 0)) <&&> (((>) x) <$> (readIOA tab (len - l))))
                             (do let m = l - 1
                                 b m)
                             (do let n = l + 1
                                 writeIOA tab (len - n) x
                                 let o = if n > k
                                         then let p = n
                                                      in p
                                         else k
                                 let q = g - 1
                                 a q n o) in
                         b h
           else return k in
           a i j max0

main =
  do let len = 0
     f <- read_int
     let r = f
     skip_whitespaces
     tab <- array_init r (\ i ->
                            do let x = 0
                               e <- read_int
                               let s = e
                               skip_whitespaces
                               return s)
     printf "%d" =<< (montagnes0 tab r :: IO Int)


