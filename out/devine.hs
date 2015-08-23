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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
devine0 nombre tab len =
  do min0 <- readIOA tab 0
     max0 <- readIOA tab 1
     let a i b c =
           if i <= len - 1
           then ifM ((((<) b) <$> (readIOA tab i)) <||> (((>) c) <$> (readIOA tab i)))
                    (return False)
                    (do d <- ifM (((>) nombre) <$> (readIOA tab i))
                                 (readIOA tab i)
                                 (return c)
                        e <- ifM (((<) nombre) <$> (readIOA tab i))
                                 (readIOA tab i)
                                 (return b)
                        ifM (((&&) (len /= i + 1)) <$> (((==) nombre) <$> (readIOA tab i)))
                            (return False)
                            (a (i + 1) e d))
           else return True in
           a 2 max0 min0

main =
  do nombre <- read_int
     skip_whitespaces
     len <- read_int
     skip_whitespaces
     tab <- array_init len (\ i ->
                              do tmp <- read_int
                                 skip_whitespaces
                                 return tmp)
     ifM (devine0 nombre tab len)
         (printf "True" :: IO ())
         (printf "False" :: IO ())


