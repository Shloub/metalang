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
  do let out0 = 0
     let b = taille - 1
     let a i c =
           if i <= b
           then do d <- (((+) c) <$> (((*) i) <$> (fmap ord (readIOA tableau i))))
                   printf "%c" =<< (readIOA tableau i :: IO Char)
                   a (i + 1) d
           else do printf "--\n" :: IO ()
                   return c in
           a 0 out0

main =
  do taille <- (fmap read getLine)
     tableau <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return taille)) <*> getLine))
     printf "%d\n" =<< ((programme_candidat tableau taille)::IO Int)


