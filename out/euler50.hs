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
                        let q = p + 1
                        m (k + 1) q)
                    (m (k + 1) p)
           else do printf "%d == %d\n" (p::Int) (nprimes::Int) :: IO()
                   sum <- array_init nprimes (\ i_ ->
                                                readIOA primes i_)
                   let stop = 1000001 - 1
                   let r s u v w x =
                         if v
                         then let y i z ba bb bc =
                                    if i <= bc
                                    then if i + s < nprimes
                                         then do writeIOA sum i =<< ((+) <$> (readIOA sum i) <*> (readIOA primes (i + s)))
                                                 ifM (((>) 1000001) <$> (readIOA sum i))
                                                     (ifM ((==) <$> (readIOA era =<< (readIOA sum i)) <*> (readIOA sum i))
                                                          (do bd <- readIOA sum i
                                                              y (i + 1) s True bd bc)
                                                          (y (i + 1) z True bb bc))
                                                     (do let be = (min bc i)
                                                         y (i + 1) z ba bb be)
                                         else y (i + 1) z ba bb bc
                                    else do let bf = s + 1
                                            r bf z ba bb bc in
                                    y 0 u False w x
                         else printf "%d\n%d\n" (w::Int) (u::Int) :: IO() in
                         r 1 0 True 1 stop in
           m 2 0


