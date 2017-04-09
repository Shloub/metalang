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
is_number c =
  return ((ord c) <= (ord '9') && (ord c) >= (ord '0'))

npi0 str len =
  do stack <- array_init len (\ i ->
                                return 0)
     let a b d =
           if d < len
           then ifM (((==) ' ') <$> (readIOA str d))
                    (do let n = d + 1
                        a b n)
                    (ifM ((readIOA str d) >>= is_number)
                         (let g h j =
                                ifM (((/=) ' ') <$> (readIOA str j))
                                    (do l <- ((-) <$> (((+) (h * 10)) <$> (fmap ord (readIOA str j))) <*> (return (ord '0')))
                                        let m = j + 1
                                        g l m)
                                    (do writeIOA stack b h
                                        let k = b + 1
                                        a k j) in
                                g 0 d)
                         (ifM (((==) '+') <$> (readIOA str d))
                              (do writeIOA stack (b - 2) =<< ((+) <$> (readIOA stack (b - 2)) <*> (readIOA stack (b - 1)))
                                  let e = b - 1
                                  let f = d + 1
                                  a e f)
                              (a b d)))
           else readIOA stack 0 in
           a 0 0

main =
  do o <- read_int
     skip_whitespaces
     tab <- array_init o (\ i ->
                            getChar)
     result <- npi0 tab o
     printf "%d" (result :: Int) :: IO ()


