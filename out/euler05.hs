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

primesfactors n =
  do tab <- array_init (n + 1) (\ i ->
                                  return 0)
     let f v w =
           if w /= 1 && v * v <= w
           then if (w `rem` v) == 0
                then do writeIOA tab v =<< (((+) 1) <$> (readIOA tab v))
                        let x = w `quot` v
                        f v x
                else do let y = v + 1
                        f y w
           else do writeIOA tab w =<< (((+) 1) <$> (readIOA tab w))
                   return tab in
           f 2 n

main =
  do o <- array_init (20 + 1) (\ m ->
                                 return 0)
     let s i =
           if i <= 20
           then do t <- primesfactors i
                   let u j =
                         if j <= i
                         then do writeIOA o j =<< ((max <$> (readIOA o j) <*> (readIOA t j)))
                                 u (j + 1)
                         else s (i + 1) in
                         u 1
           else let p k z =
                      if k <= 20
                      then do r <- readIOA o k
                              let q l ba =
                                    if l <= r
                                    then do let bb = ba * k
                                            q (l + 1) bb
                                    else p (k + 1) ba in
                                    q 1 z
                      else printf "%d\n" (z::Int) :: IO() in
                      p 1 1 in
           s 1


