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
  let a i b =
        if i <= taille1 - 1
        then do c <- (((+) b) <$> (((*) i) <$> (fmap ord (readIOA tableau1 i))))
                printf "%c" =<< (readIOA tableau1 i :: IO Char)
                a (i + 1) c
        else do printf "--\n" :: IO ()
                let d j e =
                      if j <= taille2 - 1
                      then do f <- (((+) e) <$> (((*) (j * 100)) <$> (fmap ord (readIOA tableau2 j))))
                              printf "%c" =<< (readIOA tableau2 j :: IO Char)
                              d (j + 1) f
                      else do printf "--\n" :: IO ()
                              return e in
                      d 0 b in
        a 0 0

main =
  do taille1 <- (fmap read getLine)
     tableau1 <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return taille1)) <*> getLine))
     taille2 <- (fmap read getLine)
     tableau2 <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return taille2)) <*> getLine))
     printf "%d\n" =<< ((programme_candidat tableau1 taille1 tableau2 taille2)::IO Int)


