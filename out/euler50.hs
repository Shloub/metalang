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
  let c i d =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let e = d + 1
                     if (max0 `quot` i) > i
                     then do let j = i * i
                             let f g =
                                   if g < max0 && g > 0
                                   then do writeIOA t g 0
                                           let h = g + i
                                           f h
                                   else c (i + 1) e in
                                   f j
                     else c (i + 1) e)
                 (c (i + 1) d)
        else return d in
        c 2 0

main =
  do era <- array_init 1000001 (\ j ->
                                  return j)
     nprimes <- eratostene era 1000001
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let m k p =
           if k <= 1000001 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes p k
                        let bf = p + 1
                        m (k + 1) bf)
                    (m (k + 1) p)
           else do printf "%d == %d\n" (p::Int) (nprimes::Int) :: IO()
                   sum <- array_init nprimes (\ i_ ->
                                                readIOA primes i_)
                   let stop = 1000001 - 1
                   let q r s u v w =
                         if u
                         then let x i y z ba bb =
                                    if i <= bb
                                    then if i + r < nprimes
                                         then do writeIOA sum i =<< ((+) <$> (readIOA sum i) <*> (readIOA primes (i + r)))
                                                 ifM (((>) 1000001) <$> (readIOA sum i))
                                                     (ifM ((==) <$> (readIOA era =<< (readIOA sum i)) <*> (readIOA sum i))
                                                          (do be <- readIOA sum i
                                                              x (i + 1) r True be bb)
                                                          (x (i + 1) y True ba bb))
                                                     (do let bd = (min bb i)
                                                         x (i + 1) y z ba bd)
                                         else x (i + 1) y z ba bb
                                    else do let bc = r + 1
                                            q bc y z ba bb in
                                    x 0 s False v w
                         else printf "%d\n%d\n" (v::Int) (s::Int) :: IO() in
                         q 1 0 True 1 stop in
           m 2 0


