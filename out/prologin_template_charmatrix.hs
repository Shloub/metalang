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



programme_candidat tableau taille_x taille_y =
  do let f = taille_y - 1
     let c i k =
           if i <= f
           then do let e = taille_x - 1
                   let d j l =
                         if j <= e
                         then do m <- (((+) l) <$> (((*) (i + j * 2)) <$> (fmap ord (join $ readIOA <$> (readIOA tableau i) <*> return j))))
                                 printf "%c" =<< (join $ readIOA <$> (readIOA tableau i) <*> return j :: IO Char)
                                 d (j + 1) m
                         else do printf "--\n" :: IO ()
                                 c (i + 1) l in
                         d 0 k
           else return k in
           c 0 0

main =
  do taille_x <- (fmap read getLine)
     taille_y <- (fmap read getLine)
     a <- array_init taille_y (\ b ->
                                 (join (newListArray <$> (fmap (\x -> (0, x-1)) (return taille_x)) <*> getLine)))
     printf "%d\n" =<< ((programme_candidat a taille_x taille_y)::IO Int)


