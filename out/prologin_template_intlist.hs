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

main :: IO ()


programme_candidat tableau taille =
  let a i b =
        if i <= taille - 1
        then do c <- (((+) b) <$> (readIOA tableau i))
                a (i + 1) c
        else return b in
        a 0 0

main =
  do taille <- (fmap read getLine)
     tableau <- (join (newListArray . (,) 0 . subtract 1 <$> return taille <*> fmap (map read . words) getLine))
     printf "%d\n" =<< ((programme_candidat tableau taille)::IO Int)


