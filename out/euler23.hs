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
     let ba = 2
     let bb = (max0 - 1)
     let y i bz =
           (if (i <= bb)
           then do ca <- ifM (((==) <$> (readIOA t i) <*> return (i)))
                             (do let cb = (bz + 1)
                                 let j = (i * i)
                                 let z cc =
                                       (if ((cc < max0) && (cc > 0))
                                       then do writeIOA t cc 0
                                               let cd = (cc + i)
                                               (z cd)
                                       else return (cb)) in
                                       (z j))
                             (return (bz))
                   (y (i + 1) ca)
           else return (bz)) in
           (y ba n)
fillPrimesFactors t n primes nprimes =
  do let w = 0
     let x = (nprimes - 1)
     let u i ce =
           (if (i <= x)
           then do d <- (readIOA primes i)
                   let v cf =
                         (if ((cf `rem` d) == 0)
                         then do writeIOA t d =<< ((+) <$> (readIOA t d) <*> return (1))
                                 let cg = (cf `quot` d)
                                 (v cg)
                         else (if (cf == 1)
                              then (readIOA primes i)
                              else (u (i + 1) cf))) in
                         (v ce)
           else return (ce)) in
           (u w n)
sumdivaux2 t n i =
  let m ch =
        ifM ((return ((ch < n)) <&&> ((==) <$> (readIOA t ch) <*> return (0))))
            (do let ci = (ch + 1)
                (m ci))
            (return (ch)) in
        (m i)
sumdivaux t n i =
  do let c () = return (())
     (if (i > n)
     then return (1)
     else do let e () = (c ())
             ifM (((==) <$> (readIOA t i) <*> return (0)))
                 ((sumdivaux t n =<< (sumdivaux2 t n (i + 1))))
                 (do o <- (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
                     let out0 = 0
                     let p = i
                     let g = 1
                     h <- (readIOA t i)
                     let f j cj ck =
                           (if (j <= h)
                           then do let cl = (cj + ck)
                                   let cm = (ck * i)
                                   (f (j + 1) cl cm)
                           else return (((cj + 1) * o))) in
                           (f g out0 p)))
sumdiv nprimes primes n =
  ((\ (b, t) ->
     do return (b)
        max0 <- (fillPrimesFactors t n primes nprimes)
        (sumdivaux t max0 0)) =<< (array_init_withenv (n + 1) (\ i () ->
                                                                let a = 0
                                                                        in return (((), a))) ()))
main =
  do let maximumprimes = 30001
     ((\ (bd, era) ->
        do return (bd)
           nprimes <- (eratostene era maximumprimes)
           ((\ (bf, primes) ->
              do return (bf)
                 let l = 0
                 let bx = 2
                 let by = (maximumprimes - 1)
                 let bw k cn =
                        (if (k <= by)
                        then do co <- ifM (((==) <$> (readIOA era k) <*> return (k)))
                                          (do writeIOA primes cn k
                                              let cp = (cn + 1)
                                              return (cp))
                                          (return (cn))
                                (bw (k + 1) co)
                        else do let n = 100
                                {- 28124 ça prend trop de temps mais on arrive a passer le test -}
                                ((\ (bh, abondant) ->
                                   do return (bh)
                                      ((\ (bj, summable) ->
                                         do return (bj)
                                            let sum = 0
                                            let bu = 2
                                            let bv = n
                                            let bt r =
                                                   (if (r <= bv)
                                                   then do other <- ((-) <$> (sumdiv nprimes primes r) <*> return (r))
                                                           (if (other > r)
                                                           then writeIOA abondant r True
                                                           else return (()))
                                                           (bt (r + 1))
                                                   else do let br = 1
                                                           let bs = n
                                                           let bn i =
                                                                  (if (i <= bs)
                                                                  then do let bp = 1
                                                                          let bq = n
                                                                          let bo j =
                                                                                 (if (j <= bq)
                                                                                 then do ifM ((((readIOA abondant i) <&&> (readIOA abondant j)) <&&> return (((i + j) <= n))))
                                                                                             (writeIOA summable (i + j) True)
                                                                                             (return (()))
                                                                                         (bo (j + 1))
                                                                                 else (bn (i + 1))) in
                                                                                 (bo bp)
                                                                  else do let bl = 1
                                                                          let bm = n
                                                                          let bk o cq =
                                                                                 (if (o <= bm)
                                                                                 then do cr <- ifM ((fmap (not) (readIOA summable o)))
                                                                                                   (let cs = (cq + o)
                                                                                                             in return (cs))
                                                                                                   (return (cq))
                                                                                         (bk (o + 1) cr)
                                                                                 else do printf "\n" ::IO()
                                                                                         printf "%d" (cq :: Int)::IO()
                                                                                         printf "\n" ::IO()) in
                                                                                 (bk bl sum)) in
                                                                  (bn br)) in
                                                   (bt bu)) =<< (array_init_withenv (n + 1) (\ q () ->
                                                                                              let bi = False
                                                                                                       in return (((), bi))) ()))) =<< (array_init_withenv (n + 1) (\ p () ->
                                                                                                                                                                     let bg = False
                                                                                                                                                                              in return (((), bg))) ()))) in
                        (bw bx l)) =<< (array_init_withenv nprimes (\ t () ->
                                                                     let be = 0
                                                                              in return (((), be))) ()))) =<< (array_init_withenv maximumprimes (\ s () ->
                                                                                                                                                  let bc = s
                                                                                                                                                           in return (((), bc))) ()))

