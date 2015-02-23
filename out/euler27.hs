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
     let m = 2
     let p = (max0 - 1)
     let g i be =
           (if (i <= p)
           then do bf <- ifM (((==) <$> (readIOA t i) <*> return (i)))
                             (do let bg = (be + 1)
                                 let j = (i * i)
                                 let h bh =
                                       (if ((bh < max0) && (bh > 0))
                                       then do writeIOA t bh 0
                                               let bi = (bh + i)
                                               (h bi)
                                       else return (bg)) in
                                       (h j))
                             (return (be))
                   (g (i + 1) bf)
           else return (be)) in
           (g m n)
isPrime n primes len =
  do let i = 0
     let bj = (if (n < 0)
              then let bk = (- n)
                            in bk
              else n)
     let f bl =
           ifM (((<) <$> ((*) <$> (readIOA primes bl) <*> (readIOA primes bl)) <*> return (bj)))
               (ifM (((==) <$> ((rem bj) <$> (readIOA primes bl)) <*> return (0)))
                    (return (False))
                    (do let bm = (bl + 1)
                        (f bm)))
               (return (True)) in
           (f i)
test a b primes len =
  do let d = 0
     let e = 200
     let c n =
           (if (n <= e)
           then do let j = (((n * n) + (a * n)) + b)
                   ifM ((fmap (not) (isPrime j primes len)))
                       (return (n))
                       ((c (n + 1)))
           else return (200)) in
           (c d)
main =
  do let maximumprimes = 1000
     ((\ (r, era) ->
        do return (r)
           let result = 0
           let max0 = 0
           nprimes <- (eratostene era maximumprimes)
           ((\ (u, primes) ->
              do return (u)
                 let l = 0
                 let bc = 2
                 let bd = (maximumprimes - 1)
                 let bb k bn =
                        (if (k <= bd)
                        then do bo <- ifM (((==) <$> (readIOA era k) <*> return (k)))
                                          (do writeIOA primes bn k
                                              let bp = (bn + 1)
                                              return (bp))
                                          (return (bn))
                                (bb (k + 1) bo)
                        else do printf "%d" (bn :: Int)::IO()
                                printf " == " ::IO()
                                printf "%d" (nprimes :: Int)::IO()
                                printf "\n" ::IO()
                                let ma = 0
                                let mb = 0
                                let z = 3
                                let ba = 999
                                let v b bq br bs bt =
                                      (if (b <= ba)
                                      then ((\ (bu, bv, bw, bx) ->
                                              (v (b + 1) bu bv bw bx)) =<< ifM (((==) <$> (readIOA era b) <*> return (b)))
                                                                               (do let x = (- 999)
                                                                                   let y = 999
                                                                                   let w a by bz ca cb =
                                                                                         (if (a <= y)
                                                                                         then do n1 <- (test a b primes nprimes)
                                                                                                 n2 <- (test a (- b) primes nprimes)
                                                                                                 ((\ (cc, cd, ce, cf) ->
                                                                                                    ((\ (cg, ch, ci, cj) ->
                                                                                                       (w (a + 1) cg ch ci cj)) (if (n2 > cd)
                                                                                                                                then let ck = n2
                                                                                                                                              in let cl = ((- a) * b)
                                                                                                                                                          in let cm = a
                                                                                                                                                                      in let cn = (- b)
                                                                                                                                                                                  in (cm, ck, cn, cl)
                                                                                                                                else (cc, cd, ce, cf)))) (if (n1 > bz)
                                                                                                                                                         then let co = n1
                                                                                                                                                                       in let cp = (a * b)
                                                                                                                                                                                   in let cq = a
                                                                                                                                                                                               in let cr = b
                                                                                                                                                                                                           in (cq, co, cr, cp)
                                                                                                                                                         else (by, bz, ca, cb)))
                                                                                         else return ((by, bz, ca, cb))) in
                                                                                         (w x bq br bs bt))
                                                                               (return ((bq, br, bs, bt))))
                                      else do printf "%d" (bq :: Int)::IO()
                                              printf " " ::IO()
                                              printf "%d" (bs :: Int)::IO()
                                              printf "\n" ::IO()
                                              printf "%d" (br :: Int)::IO()
                                              printf "\n" ::IO()
                                              printf "%d" (bt :: Int)::IO()
                                              printf "\n" ::IO()) in
                                      (v z ma max0 mb result)) in
                        (bb bc l)) =<< (array_init_withenv nprimes (\ o () ->
                                                                     let s = 0
                                                                             in return (((), s))) ()))) =<< (array_init_withenv maximumprimes (\ j () ->
                                                                                                                                                let q = j
                                                                                                                                                        in return (((), q))) ()))

