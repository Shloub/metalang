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



programme_candidat tableau1 taille1 tableau2 taille2 =
  do let out0 = 0
     let d = taille1 - 1
     let c i e =
           if i <= d
           then do f <- (((+) e) <$> (((*) i) <$> (fmap ord (readIOA tableau1 i))))
                   printf "%c" =<< (readIOA tableau1 i :: IO Char)
                   c (i + 1) f
           else do printf "--\n" :: IO ()
                   let b = taille2 - 1
                   let a j g =
                         if j <= b
                         then do h <- (((+) g) <$> (((*) (j * 100)) <$> (fmap ord (readIOA tableau2 j))))
                                 printf "%c" =<< (readIOA tableau2 j :: IO Char)
                                 a (j + 1) h
                         else do printf "--\n" :: IO ()
                                 return g in
                         a 0 e in
           c 0 out0

main =
  do taille1 <- (fmap read getLine)
     taille2 <- (fmap read getLine)
     tableau1 <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return taille1)) <*> getLine))
     tableau2 <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return taille2)) <*> getLine))
     printf "%d" =<< (programme_candidat tableau1 taille1 tableau2 taille2 :: IO Int)
     printf "\n" :: IO ()


