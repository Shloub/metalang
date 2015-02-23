import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b


main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())

read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)


array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     o <- newListArray (0, len - 1) li
     return (env, o)
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)



max2_ a b =
  let bi () = ()
              in return ((if (a > b)
                         then a
                         else b))
eratostene t max0 =
  do let n = 0
     let bg = 2
     let bh = (max0 - 1)
     let be i bj =
            (if (i <= bh)
            then do bk <- ifM (((==) <$> (readIOA t i) <*> return (i)))
                              (do let j = (i * i)
                                  let bl = (bj + 1)
                                  let bf bm =
                                         (if ((bm < max0) && (bm > 0))
                                         then do writeIOA t bm 0
                                                 let bn = (bm + i)
                                                 (bf bn)
                                         else return (bl)) in
                                         (bf j))
                              (return (bj))
                    (be (i + 1) bk)
            else return (bj)) in
            (be bg n)
fillPrimesFactors t n primes nprimes =
  do let bc = 0
     let bd = (nprimes - 1)
     let ba i bo =
            (if (i <= bd)
            then do d <- (readIOA primes i)
                    let bb bp =
                           (if ((bp `rem` d) == 0)
                           then do writeIOA t d =<< ((+) <$> (readIOA t d) <*> return (1))
                                   let bq = (bp `quot` d)
                                   (bb bq)
                           else (if (bp == 1)
                                then (readIOA primes i)
                                else (ba (i + 1) bp))) in
                           (bb bo)
            else return (bo)) in
            (ba bc n)
find ndiv2 =
  do let maximumprimes = 110
     ((\ (e, era) ->
        do return (e)
           nprimes <- (eratostene era maximumprimes)
           ((\ (g, primes) ->
              do return (g)
                 let l = 0
                 let y = 2
                 let z = (maximumprimes - 1)
                 let x k br =
                       (if (k <= z)
                       then do bs <- ifM (((==) <$> (readIOA era k) <*> return (k)))
                                         (do writeIOA primes br k
                                             let bt = (br + 1)
                                             return (bt))
                                         (return (br))
                               (x (k + 1) bs)
                       else do let v = 1
                               let w = 10000
                               let h n =
                                     (if (n <= w)
                                     then ((\ (q, primesFactors) ->
                                             do return (q)
                                                max0 <- (join (max2_ <$> (fillPrimesFactors primesFactors n primes nprimes) <*> (fillPrimesFactors primesFactors (n + 1) primes nprimes)))
                                                writeIOA primesFactors 2 =<< ((-) <$> (readIOA primesFactors 2) <*> return (1))
                                                let ndivs = 1
                                                let s = 0
                                                let u = max0
                                                let r i bu =
                                                      (if (i <= u)
                                                      then do bv <- ifM (((/=) <$> (readIOA primesFactors i) <*> return (0)))
                                                                        (do bw <- (((*) bu) <$> (((+) 1) <$> (readIOA primesFactors i)))
                                                                            return (bw))
                                                                        (return (bu))
                                                              (r (i + 1) bv)
                                                      else (if (bu > ndiv2)
                                                           then return (((n * (n + 1)) `quot` 2))
                                                           else {- print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" -}
                                                                (h (n + 1)))) in
                                                      (r s ndivs)) =<< (array_init_withenv (n + 2) (\ m () ->
                                                                                                     let p = 0
                                                                                                             in return (((), p))) ()))
                                     else return (0)) in
                                     (h v)) in
                       (x y l)) =<< (array_init_withenv nprimes (\ o () ->
                                                                  let f = 0
                                                                          in return (((), f))) ()))) =<< (array_init_withenv maximumprimes (\ j () ->
                                                                                                                                             let c = j
                                                                                                                                                     in return (((), c))) ()))
main =
  do printf "%d" =<< ((find 500) :: IO Int)
     printf "\n" ::IO()
     return (())

