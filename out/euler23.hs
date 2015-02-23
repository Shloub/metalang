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



eratostene t max0 =
  do let n = 0
     let w = (max0 - 1)
     let u i bl =
           (if (i <= w)
           then ifM (((==) <$> (readIOA t i) <*> return (i)))
                    (do let bm = (bl + 1)
                        let j = (i * i)
                        let v bn =
                              (if ((bn < max0) && (bn > 0))
                              then do writeIOA t bn 0
                                      let bo = (bn + i)
                                      (v bo)
                              else (u (i + 1) bm)) in
                              (v j))
                    ((u (i + 1) bl))
           else return (bl)) in
           (u 2 n)
fillPrimesFactors t n primes nprimes =
  do let m = (nprimes - 1)
     let g i bp =
           (if (i <= m)
           then do d <- (readIOA primes i)
                   let h bq =
                         (if ((bq `rem` d) == 0)
                         then do writeIOA t d =<< ((+) <$> (readIOA t d) <*> return (1))
                                 let br = (bq `quot` d)
                                 (h br)
                         else (if (bq == 1)
                              then (readIOA primes i)
                              else (g (i + 1) bq))) in
                         (h bp)
           else return (bp)) in
           (g 0 n)
sumdivaux2 t n i =
  let f bs =
        ifM ((return ((bs < n)) <&&> ((==) <$> (readIOA t bs) <*> return (0))))
            (do let bt = (bs + 1)
                (f bt))
            (return (bs)) in
        (f i)
sumdivaux t n i =
  (if (i > n)
  then return (1)
  else ifM (((==) <$> (readIOA t i) <*> return (0)))
           ((sumdivaux t n =<< (sumdivaux2 t n (i + 1))))
           (do o <- (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
               let out0 = 0
               let p = i
               e <- (readIOA t i)
               let c j bu bv =
                     (if (j <= e)
                     then do let bw = (bu + bv)
                             let bx = (bv * i)
                             (c (j + 1) bw bx)
                     else return (((bu + 1) * o))) in
                     (c 1 out0 p)))
sumdiv nprimes primes n =
  ((\ (b, t) ->
     do return (b)
        max0 <- (fillPrimesFactors t n primes nprimes)
        (sumdivaux t max0 0)) =<< (array_init_withenv (n + 1) (\ i () ->
                                                                let a = 0
                                                                        in return (((), a))) ()))
main =
  do let maximumprimes = 30001
     ((\ (y, era) ->
        do return (y)
           nprimes <- (eratostene era maximumprimes)
           ((\ (ba, primes) ->
              do return (ba)
                 let l = 0
                 let bk = (maximumprimes - 1)
                 let bj k by =
                        (if (k <= bk)
                        then ifM (((==) <$> (readIOA era k) <*> return (k)))
                                 (do writeIOA primes by k
                                     let bz = (by + 1)
                                     (bj (k + 1) bz))
                                 ((bj (k + 1) by))
                        else do let n = 100
                                {- 28124 ça prend trop de temps mais on arrive a passer le test -}
                                ((\ (bc, abondant) ->
                                   do return (bc)
                                      ((\ (be, summable) ->
                                         do return (be)
                                            let sum = 0
                                            let bi r =
                                                   (if (r <= n)
                                                   then do other <- ((-) <$> (sumdiv nprimes primes r) <*> return (r))
                                                           (if (other > r)
                                                           then do writeIOA abondant r True
                                                                   (bi (r + 1))
                                                           else (bi (r + 1)))
                                                   else let bg i =
                                                               (if (i <= n)
                                                               then let bh j =
                                                                           (if (j <= n)
                                                                           then ifM ((((readIOA abondant i) <&&> (readIOA abondant j)) <&&> return (((i + j) <= n))))
                                                                                    (do writeIOA summable (i + j) True
                                                                                        (bh (j + 1)))
                                                                                    ((bh (j + 1)))
                                                                           else (bg (i + 1))) in
                                                                           (bh 1)
                                                               else let bf o ca =
                                                                           (if (o <= n)
                                                                           then ifM ((fmap (not) (readIOA summable o)))
                                                                                    (do let cb = (ca + o)
                                                                                        (bf (o + 1) cb))
                                                                                    ((bf (o + 1) ca))
                                                                           else do printf "\n" ::IO()
                                                                                   printf "%d" (ca :: Int)::IO()
                                                                                   printf "\n" ::IO()) in
                                                                           (bf 1 sum)) in
                                                               (bg 1)) in
                                                   (bi 2)) =<< (array_init_withenv (n + 1) (\ q () ->
                                                                                             let bd = False
                                                                                                      in return (((), bd))) ()))) =<< (array_init_withenv (n + 1) (\ p () ->
                                                                                                                                                                    let bb = False
                                                                                                                                                                             in return (((), bb))) ()))) in
                        (bj 2 l)) =<< (array_init_withenv nprimes (\ t () ->
                                                                    let z = 0
                                                                            in return (((), z))) ()))) =<< (array_init_withenv maximumprimes (\ s () ->
                                                                                                                                               let x = s
                                                                                                                                                       in return (((), x))) ()))

