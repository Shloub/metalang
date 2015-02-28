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
  do let n = 0
     let e = max0 - 1
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
           c 2 n

main =
  do let maximumprimes = 1000001
     era <- array_init maximumprimes (\ j ->
                                        return j)
     nprimes <- eratostene era maximumprimes
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let l = 0
     let v = maximumprimes - 1
     let u k ba =
           if k <= v
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes ba k
                        let bb = ba + 1
                        u (k + 1) bb)
                    (u (k + 1) ba)
           else do printf "%d" (ba :: Int) :: IO ()
                   printf " == " :: IO ()
                   printf "%d" (nprimes :: Int) :: IO ()
                   printf "\n" :: IO ()
                   sum <- array_init nprimes (\ i_ ->
                                                readIOA primes i_)
                   let maxl = 0
                   let process = True
                   let stop = maximumprimes - 1
                   let len = 1
                   let resp = 1
                   let r bc bd be bf bg =
                         if be
                         then do let bh = False
                                 let s i bi bj bk bl =
                                       if i <= bl
                                       then if i + bc < nprimes
                                            then do writeIOA sum i =<< ((+) <$> (readIOA sum i) <*> (readIOA primes (i + bc)))
                                                    ifM (((>) maximumprimes) <$> (readIOA sum i))
                                                        (do let bm = True
                                                            ifM ((==) <$> (readIOA era =<< (readIOA sum i)) <*> (readIOA sum i))
                                                                (do let bn = bc
                                                                    bo <- readIOA sum i
                                                                    s (i + 1) bn bm bo bl)
                                                                (s (i + 1) bi bm bk bl))
                                                        (do bp <- min2_ bl i
                                                            s (i + 1) bi bj bk bp)
                                            else s (i + 1) bi bj bk bl
                                       else do let bq = bc + 1
                                               r bq bi bj bk bl in
                                       s 0 bd bh bf bg
                         else do printf "%d" (bf :: Int) :: IO ()
                                 printf "\n" :: IO ()
                                 printf "%d" (bd :: Int) :: IO ()
                                 printf "\n" :: IO () in
                         r len maxl process resp stop in
           u 2 l


