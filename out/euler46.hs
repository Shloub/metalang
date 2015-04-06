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
  let a i b =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let c = b + 1
                     if (max0 `quot` i) > i
                     then do let j = i * i
                             let d e =
                                   if e < max0 && e > 0
                                   then do writeIOA t e 0
                                           let f = e + i
                                           d f
                                   else a (i + 1) c in
                                   d j
                     else a (i + 1) c)
                 (a (i + 1) b)
        else return b in
        a 2 0

main =
  do era <- array_init 6000 (\ j_ ->
                               return j_)
     nprimes <- eratostene era 6000
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let g k h =
           if k <= 6000 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes h k
                        let p = h + 1
                        g (k + 1) p)
                    (g (k + 1) h)
           else do printf "%d == %d\n" (h::Int) (nprimes::Int) :: IO()
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
                         else let s m =
                                    if m <= 6000
                                    then do let m2 = m * 2 + 1
                                            ifM ((return (m2 < 6000)) <&&> (fmap not (readIOA canbe m2)))
                                                (do printf "%d\n" (m2::Int) :: IO()
                                                    s (m + 1))
                                                (s (m + 1))
                                    else return () in
                                    s 1 in
                         q 0 in
           g 2 0


