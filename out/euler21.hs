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
  let m i y =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let z = y + 1
                     let j = i * i
                     let q ba =
                           if ba < max0 && ba > 0
                           then do writeIOA t ba 0
                                   let bb = ba + i
                                   q bb
                           else m (i + 1) z in
                           q j)
                 (m (i + 1) y)
        else return y in
        m 2 0

fillPrimesFactors t n primes nprimes =
  let g i bc =
        if i <= nprimes - 1
        then do d <- readIOA primes i
                let h bd =
                      if (bd `rem` d) == 0
                      then do writeIOA t d =<< (((+) 1) <$> (readIOA t d))
                              let be = bd `quot` d
                              h be
                      else if bd == 1
                           then readIOA primes i
                           else g (i + 1) bd in
                      h bc
        else return bc in
        g 0 n

sumdivaux2 t n i =
  let f bf =
        ifM ((return (bf < n)) <&&> (((==) 0) <$> (readIOA t bf)))
            (do let bg = bf + 1
                f bg)
            (return bf) in
        f i

sumdivaux t n i =
  if i > n
  then return 1
  else ifM (((==) 0) <$> (readIOA t i))
           (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
           (do o <- sumdivaux t n =<< (sumdivaux2 t n (i + 1))
               e <- readIOA t i
               let c j bh bi =
                     if j <= e
                     then do let bj = bh + bi
                             let bk = bi * i
                             c (j + 1) bj bk
                     else return ((bh + 1) * o) in
                     c 1 0 i)

sumdiv nprimes primes n =
  do t <- array_init (n + 1) (\ i ->
                                return 0)
     max0 <- fillPrimesFactors t n primes nprimes
     sumdivaux t max0 0

main =
  do era <- array_init 1001 (\ j ->
                               return j)
     nprimes <- eratostene era 1001
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let x k bl =
           if k <= 1001 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes bl k
                        let bm = bl + 1
                        x (k + 1) bm)
                    (x (k + 1) bl)
           else do printf "%d == %d\n" (bl::Int) (nprimes::Int) :: IO()
                   let w n bn =
                         if n <= 1000
                         then do other <- ((-) <$> (sumdiv nprimes primes n) <*> (return n))
                                 if other > n
                                 then do othersum <- ((-) <$> (sumdiv nprimes primes other) <*> (return other))
                                         if othersum == n
                                         then do printf "%d & %d\n" (other::Int) (n::Int) :: IO()
                                                 let bo = bn + other + n
                                                 w (n + 1) bo
                                         else w (n + 1) bn
                                 else w (n + 1) bn
                         else printf "\n%d\n" (bn::Int) :: IO() in
                         w 2 0 in
           x 2 0


