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
min2_ a b =
  return (if a < b
          then a
          else b)

eratostene t max0 =
  do let e = max0 - 1
     let c i w =
           if i <= e
           then ifM (((==) i) <$> (readIOA t i))
                    (do let x = w + 1
                        if (max0 `quot` i) > i
                        then do let j = i * i
                                let d y =
                                      if y < max0 && y > 0
                                      then do writeIOA t y 0
                                              let z = y + i
                                              d z
                                      else c (i + 1) x in
                                      d j
                        else c (i + 1) x)
                    (c (i + 1) w)
           else return w in
           c 2 0

main =
  do era <- array_init 1000001 (\ j ->
                                  return j)
     nprimes <- eratostene era 1000001
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let v = 1000001 - 1
     let u k ba =
           if k <= v
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes ba k
                        let bb = ba + 1
                        u (k + 1) bb)
                    (u (k + 1) ba)
           else do printf "%d == %d\n" (ba::Int) (nprimes::Int) :: IO()
                   sum <- array_init nprimes (\ i_ ->
                                                readIOA primes i_)
                   let stop = 1000001 - 1
                   let r bc bd be bf bg =
                         if be
                         then let s i bi bj bk bl =
                                    if i <= bl
                                    then if i + bc < nprimes
                                         then do writeIOA sum i =<< ((+) <$> (readIOA sum i) <*> (readIOA primes (i + bc)))
                                                 ifM (((>) 1000001) <$> (readIOA sum i))
                                                     (ifM ((==) <$> (readIOA era =<< (readIOA sum i)) <*> (readIOA sum i))
                                                          (do bo <- readIOA sum i
                                                              s (i + 1) bc True bo bl)
                                                          (s (i + 1) bi True bk bl))
                                                     (do bp <- min2_ bl i
                                                         s (i + 1) bi bj bk bp)
                                         else s (i + 1) bi bj bk bl
                                    else do let bq = bc + 1
                                            r bq bi bj bk bl in
                                    s 0 bd False bf bg
                         else printf "%d\n%d\n" (bf::Int) (bd::Int) :: IO() in
                         r 1 0 True 1 stop in
           u 2 0


