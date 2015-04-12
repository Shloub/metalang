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
main =
  do f <- array_init 10 (\ j ->
                           return 1)
     let h i =
           if i <= 9
           then do writeIOA f i =<< ((*) <$> (readIOA f i) <*> (((*) i) <$> (readIOA f (i - 1))))
                   printf "%d " =<< ((readIOA f i)::IO Int)
                   h (i + 1)
           else do printf "\n" :: IO ()
                   let k a l =
                         if a <= 9
                         then let m b n =
                                    if b <= 9
                                    then let o c p =
                                               if c <= 9
                                               then let q d r =
                                                          if d <= 9
                                                          then let s e t =
                                                                     if e <= 9
                                                                     then let u g v =
                                                                                if g <= 9
                                                                                then do sum <- ((+) <$> ((+) <$> ((+) <$> ((+) <$> ((+) <$> (readIOA f a) <*> (readIOA f b)) <*> (readIOA f c)) <*> (readIOA f d)) <*> (readIOA f e)) <*> (readIOA f g))
                                                                                        let num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g
                                                                                        let w = if a == 0
                                                                                                then let y = sum - 1
                                                                                                             in if b == 0
                                                                                                                then let z = y - 1
                                                                                                                             in if c == 0
                                                                                                                                then let ba = z - 1
                                                                                                                                              in if d == 0
                                                                                                                                                 then let bb = ba - 1
                                                                                                                                                               in bb
                                                                                                                                                 else ba
                                                                                                                                else z
                                                                                                                else y
                                                                                                else sum
                                                                                        if (w == num && w /= 1) && w /= 2
                                                                                        then do let x = v + num
                                                                                                printf "%d " (num::Int) :: IO()
                                                                                                u (g + 1) x
                                                                                        else u (g + 1) v
                                                                                else s (e + 1) v in
                                                                                u 0 t
                                                                     else q (d + 1) t in
                                                                     s 0 r
                                                          else o (c + 1) r in
                                                          q 0 p
                                               else m (b + 1) p in
                                               o 0 n
                                    else k (a + 1) n in
                                    m 0 l
                         else printf "\n%d\n" (l::Int) :: IO() in
                         k 0 0 in
           h 1


