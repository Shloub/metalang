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
eratostene t max0 =
  do let sum = 0
     let c = max0 - 1
     let a i f =
           if i <= c
           then ifM (((==) i) <$> (readIOA t i))
                    (do let g = f + i
                        if (max0 `quot` i) > i
                        then do let j = i * i
                                let b h =
                                      if h < max0 && h > 0
                                      then do writeIOA t h 0
                                              let k = h + i
                                              b k
                                      else a (i + 1) g in
                                      b j
                        else a (i + 1) g)
                    (a (i + 1) f)
           else return f in
           a 2 sum

main =
  do let n = 100000
     {- normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages -}
     do t <- array_init n (\ i ->
                            return i)
        writeIOA t 1 0
        printf "%d" =<< (eratostene t n :: IO Int)
        printf "\n" :: IO ()


