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
     let c e f =
           if f /= 1 && e * e <= f
           then if (f `rem` e) == 0
                then do writeIOA tab e =<< (((+) 1) <$> (readIOA tab e))
                        let h = f `quot` e
                        c e h
                else do let g = e + 1
                        c g f
           else do writeIOA tab f =<< (((+) 1) <$> (readIOA tab f))
                   return tab in
           c 2 n

main =
  do o <- array_init (20 + 1) (\ m ->
                                 return 0)
     let p i =
           if i <= 20
           then do t <- primesfactors i
                   let x j =
                         if j <= i
                         then do writeIOA o j =<< ((max <$> (readIOA o j) <*> (readIOA t j)))
                                 x (j + 1)
                         else p (i + 1) in
                         x 1
           else let q k r =
                      if k <= 20
                      then do s <- readIOA o k
                              let u l v =
                                    if l <= s
                                    then do let w = v * k
                                            u (l + 1) w
                                    else q (k + 1) v in
                                    u 1 r
                      else printf "%d\n" (r::Int) :: IO() in
                      q 1 1 in
           p 1


