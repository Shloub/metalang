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
main =
  {-
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
-}
  do p <- array_init 10 (\ i ->
                           return (i * i * i * i * i))
     let g a h =
           if a <= 9
           then let j b k =
                      if b <= 9
                      then let l c m =
                                 if c <= 9
                                 then let n d o =
                                            if d <= 9
                                            then let q e t =
                                                       if e <= 9
                                                       then let u f v =
                                                                  if f <= 9
                                                                  then do s <- ((+) <$> ((+) <$> ((+) <$> ((+) <$> ((+) <$> (readIOA p a) <*> (readIOA p b)) <*> (readIOA p c)) <*> (readIOA p d)) <*> (readIOA p e)) <*> (readIOA p f))
                                                                          let r = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000
                                                                          if s == r && r /= 1
                                                                          then do printf "%d%d%d%d%d%d %d\n" (f::Int) (e::Int) (d::Int) (c::Int) (b::Int) (a::Int) (r::Int) :: IO()
                                                                                  let w = v + r
                                                                                  u (f + 1) w
                                                                          else u (f + 1) v
                                                                  else q (e + 1) v in
                                                                  u 0 t
                                                       else n (d + 1) t in
                                                       q 0 o
                                            else l (c + 1) o in
                                            n 0 m
                                 else j (b + 1) m in
                                 l 0 k
                      else g (a + 1) k in
                      j 0 h
           else printf "%d" (h :: Int) :: IO () in
           g 0 0


