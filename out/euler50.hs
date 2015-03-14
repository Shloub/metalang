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
  let c i u =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let v = u + 1
                     if (max0 `quot` i) > i
                     then do let j = i * i
                             let d w =
                                   if w < max0 && w > 0
                                   then do writeIOA t w 0
                                           let x = w + i
                                           d x
                                   else c (i + 1) v in
                                   d j
                     else c (i + 1) v)
                 (c (i + 1) u)
        else return u in
        c 2 0

main =
  do era <- array_init 1000001 (\ j ->
                                  return j)
     nprimes <- eratostene era 1000001
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let s k y =
           if k <= 1000001 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes y k
                        let z = y + 1
                        s (k + 1) z)
                    (s (k + 1) y)
           else do printf "%d == %d\n" (y::Int) (nprimes::Int) :: IO()
                   sum <- array_init nprimes (\ i_ ->
                                                readIOA primes i_)
                   let stop = 1000001 - 1
                   let q ba bb bc bd be =
                         if bc
                         then let r i bg bh bi bj =
                                    if i <= bj
                                    then if i + ba < nprimes
                                         then do writeIOA sum i =<< ((+) <$> (readIOA sum i) <*> (readIOA primes (i + ba)))
                                                 ifM (((>) 1000001) <$> (readIOA sum i))
                                                     (ifM ((==) <$> (readIOA era =<< (readIOA sum i)) <*> (readIOA sum i))
                                                          (do bm <- readIOA sum i
                                                              r (i + 1) ba True bm bj)
                                                          (r (i + 1) bg True bi bj))
                                                     (do let bn = (min bj i)
                                                         r (i + 1) bg bh bi bn)
                                         else r (i + 1) bg bh bi bj
                                    else do let bo = ba + 1
                                            q bo bg bh bi bj in
                                    r 0 bb False bd be
                         else printf "%d\n%d\n" (bd::Int) (bb::Int) :: IO() in
                         q 1 0 True 1 stop in
           s 2 0


