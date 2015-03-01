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
min2_ a b =
  return (if a < b
          then a
          else b)



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
                         out0 <- (((+) 1) <$> (join $ min2_ <$> (join $ min2_ <$> (min2_ val1 val2) <*> return val3) <*> return val4))
                         join $ writeIOA <$> (readIOA cache posY) <*> return posX <*> return out0
                         return out0))

pathfind tab x y =
  do cache <- array_init y (\ i ->
                              do tmp <- array_init x (\ j ->
                                                        do printf "%c" =<< (join $ readIOA <$> (readIOA tab i) <*> return j :: IO Char)
                                                           return (- 1))
                                 printf "\n" :: IO ()
                                 return tmp)
     pathfind_aux cache tab x y 0 0

main =
  do x <- (fmap read getLine)
     y <- (fmap read getLine)
     printf "%d %d\n" (x::Int) (y::Int) :: IO()
     e <- array_init y (\ f ->
                          (join (newListArray <$> (fmap (\x -> (0, x-1)) (return x)) <*> getLine)))
     let tab = e
     result <- pathfind tab x y
     printf "%d" (result :: Int) :: IO ()


