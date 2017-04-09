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
pathfind_aux cache tab x y posX posY =
  if posX == x - 1 && posY == y - 1
  then return 0
  else if ((posX < 0 || posY < 0) || posX >= x) || posY >= y
       then return (x * y * 10)
       else ifM (((==) '#') <$> (join $ readIOA <$> (readIOA tab posY) <*> return posX))
                (return (x * y * 10))
                (ifM (((/=) (- 1)) <$> (join $ readIOA <$> (readIOA cache posY) <*> return posX))
                     (join $ readIOA <$> (readIOA cache posY) <*> return posX)
                     (do join $ writeIOA <$> (readIOA cache posY) <*> return posX <*> return (x * y * 10)
                         val1 <- pathfind_aux cache tab x y (posX + 1) posY
                         val2 <- pathfind_aux cache tab x y (posX - 1) posY
                         val3 <- pathfind_aux cache tab x y posX (posY - 1)
                         val4 <- pathfind_aux cache tab x y posX (posY + 1)
                         let out0 = 1 + (min (min (min val1 val2) val3) val4)
                         join $ writeIOA <$> (readIOA cache posY) <*> return posX <*> return out0
                         return out0))

pathfind tab x y =
  do cache <- array_init y (\ i ->
                              array_init x (\ j ->
                                              return (- 1)))
     pathfind_aux cache tab x y 0 0

main =
  do x <- read_int
     skip_whitespaces
     y <- read_int
     skip_whitespaces
     tab <- array_init y (\ i ->
                            do tab2 <- array_init x (\ j ->
                                                       getChar)
                               skip_whitespaces
                               return tab2)
     result <- pathfind tab x y
     printf "%d" (result :: Int) :: IO ()


