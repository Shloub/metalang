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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()


programme_candidat tableau x y =
  let b i c =
        if i <= y - 1
        then let d j e =
                   if j <= x - 1
                   then do f <- (((+) e) <$> (((*) (i * 2 + j)) <$> (join $ readIOA <$> (readIOA tableau i) <*> return j)))
                           d (j + 1) f
                   else b (i + 1) e in
                   d 0 c
        else return c in
        b 0 0

main =
  do taille_x <- (fmap read getLine)
     taille_y <- (fmap read getLine)
     tableau <- array_init taille_y (\ a ->
                                       (join (newListArray . (,) 0 . subtract 1 <$> return taille_x <*> fmap (map read . words) getLine)))
     printf "%d\n" =<< ((programme_candidat tableau taille_x taille_y)::IO Int)


