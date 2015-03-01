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
     let d k l =
           if l < len
           then ifM (((==) ' ') <$> (readIOA str l))
                    (do let m = l + 1
                        d k m)
                    (ifM ((readIOA str l) >>= is_number)
                         (let e n o =
                                ifM (((/=) ' ') <$> (readIOA str o))
                                    (do p <- ((-) <$> (((+) (n * 10)) <$> (fmap ord (readIOA str o))) <*> (return (ord '0')))
                                        let q = o + 1
                                        e p q)
                                    (do writeIOA stack k n
                                        let r = k + 1
                                        d r o) in
                                e 0 l)
                         (ifM (((==) '+') <$> (readIOA str l))
                              (do writeIOA stack (k - 2) =<< ((+) <$> (readIOA stack (k - 2)) <*> (readIOA stack (k - 1)))
                                  let s = k - 1
                                  let t = l + 1
                                  d s t)
                              (d k l)))
           else readIOA stack 0 in
           d 0 0

main =
  do j <- read_int
     skip_whitespaces
     tab <- array_init j (\ i ->
                            getChar)
     result <- npi0 tab j
     printf "%d" (result :: Int) :: IO ()


