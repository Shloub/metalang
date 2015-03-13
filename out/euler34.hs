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
     let r i =
           if i <= 9
           then do writeIOA f i =<< ((*) <$> (readIOA f i) <*> (((*) i) <$> (readIOA f (i - 1))))
                   printf "%d " =<< ((readIOA f i)::IO Int)
                   r (i + 1)
           else do printf "\n" :: IO ()
                   let l a s =
                         if a <= 9
                         then let m b t =
                                    if b <= 9
                                    then let n c u =
                                               if c <= 9
                                               then let o d v =
                                                          if d <= 9
                                                          then let p e w =
                                                                     if e <= 9
                                                                     then let q g x =
                                                                                if g <= 9
                                                                                then do sum <- ((+) <$> ((+) <$> ((+) <$> ((+) <$> ((+) <$> (readIOA f a) <*> (readIOA f b)) <*> (readIOA f c)) <*> (readIOA f d)) <*> (readIOA f e)) <*> (readIOA f g))
                                                                                        let num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g
                                                                                        let y = if a == 0
                                                                                                then let z = sum - 1
                                                                                                             in if b == 0
                                                                                                                then let ba = z - 1
                                                                                                                              in if c == 0
                                                                                                                                 then let bb = ba - 1
                                                                                                                                               in if d == 0
                                                                                                                                                  then let bc = bb - 1
                                                                                                                                                                in bc
                                                                                                                                                  else bb
                                                                                                                                 else ba
                                                                                                                else z
                                                                                                else sum
                                                                                        if (y == num && y /= 1) && y /= 2
                                                                                        then do let bd = x + num
                                                                                                printf "%d " (num::Int) :: IO()
                                                                                                q (g + 1) bd
                                                                                        else q (g + 1) x
                                                                                else p (e + 1) x in
                                                                                q 0 w
                                                                     else o (d + 1) w in
                                                                     p 0 v
                                                          else n (c + 1) v in
                                                          o 0 u
                                               else m (b + 1) u in
                                               n 0 t
                                    else l (a + 1) t in
                                    m 0 s
                         else printf "\n%d\n" (s::Int) :: IO() in
                         l 0 0 in
           r 1


