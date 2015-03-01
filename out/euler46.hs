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
  let a i u =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let v = u + 1
                     if (max0 `quot` i) > i
                     then do let j = i * i
                             let b w =
                                   if w < max0 && w > 0
                                   then do writeIOA t w 0
                                           let x = w + i
                                           b x
                                   else a (i + 1) v in
                                   b j
                     else a (i + 1) v)
                 (a (i + 1) u)
        else return u in
        a 2 0

main =
  do era <- array_init 6000 (\ j_ ->
                               return j_)
     nprimes <- eratostene era 6000
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let s k y =
           if k <= 6000 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes y k
                        let z = y + 1
                        s (k + 1) z)
                    (s (k + 1) y)
           else do printf "%d == %d\n" (y::Int) (nprimes::Int) :: IO()
                   canbe <- array_init 6000 (\ i_ ->
                                               return False)
                   let q i =
                         if i <= nprimes - 1
                         then let r j =
                                    if j <= 6000 - 1
                                    then do n <- (((+) (2 * j * j)) <$> (readIOA primes i))
                                            if n < 6000
                                            then do writeIOA canbe n True
                                                    r (j + 1)
                                            else r (j + 1)
                                    else q (i + 1) in
                                    r 0
                         else let p m =
                                    if m <= 6000
                                    then do let m2 = m * 2 + 1
                                            ifM ((return (m2 < 6000)) <&&> (fmap not (readIOA canbe m2)))
                                                (do printf "%d\n" (m2::Int) :: IO()
                                                    p (m + 1))
                                                (p (m + 1))
                                    else return () in
                                    p 1 in
                         q 0 in
           s 2 0


