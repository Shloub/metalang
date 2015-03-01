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
  do let c = max0 - 1
     let a i y =
           if i <= c
           then ifM (((==) i) <$> (readIOA t i))
                    (do let z = y + 1
                        if (max0 `quot` i) > i
                        then do let j = i * i
                                let b ba =
                                      if ba < max0 && ba > 0
                                      then do writeIOA t ba 0
                                              let bb = ba + i
                                              b bb
                                      else a (i + 1) z in
                                      b j
                        else a (i + 1) z)
                    (a (i + 1) y)
           else return y in
           a 2 0

main =
  do era <- array_init 6000 (\ j_ ->
                               return j_)
     nprimes <- eratostene era 6000
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let x = 6000 - 1
     let w k bc =
           if k <= x
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes bc k
                        let bd = bc + 1
                        w (k + 1) bd)
                    (w (k + 1) bc)
           else do printf "%d == %d\n" (bc::Int) (nprimes::Int) :: IO()
                   canbe <- array_init 6000 (\ i_ ->
                                               return False)
                   let v = nprimes - 1
                   let r i =
                         if i <= v
                         then do let u = 6000 - 1
                                 let s j =
                                       if j <= u
                                       then do n <- (((+) (2 * j * j)) <$> (readIOA primes i))
                                               if n < 6000
                                               then do writeIOA canbe n True
                                                       s (j + 1)
                                               else s (j + 1)
                                       else r (i + 1) in
                                       s 0
                         else let q m =
                                    if m <= 6000
                                    then do let m2 = m * 2 + 1
                                            ifM ((return (m2 < 6000)) <&&> (fmap not (readIOA canbe m2)))
                                                (do printf "%d\n" (m2::Int) :: IO()
                                                    q (m + 1))
                                                (q (m + 1))
                                    else return () in
                                    q 1 in
                         r 0 in
           w 2 0


