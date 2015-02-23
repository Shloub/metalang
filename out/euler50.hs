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



min2_ a b =
  let g () = ()
             in return ((if (a < b)
                        then a
                        else b))
eratostene t max0 =
  do let n = 0
     let e = 2
     let f = (max0 - 1)
     let c i bb =
           (if (i <= f)
           then do bc <- ifM (((==) <$> (readIOA t i) <*> return (i)))
                             (do let bd = (bb + 1)
                                 (if ((max0 `quot` i) > i)
                                 then do let j = (i * i)
                                         let d be =
                                               (if ((be < max0) && (be > 0))
                                               then do writeIOA t be 0
                                                       let bf = (be + i)
                                                       (d bf)
                                               else return (())) in
                                               (d j)
                                 else return (()))
                                 return (bd))
                             (return (bb))
                   (c (i + 1) bc)
           else return (bb)) in
           (c e n)
main =
  do let maximumprimes = 1000001
     ((\ (m, era) ->
        do return (m)
           nprimes <- (eratostene era maximumprimes)
           ((\ (q, primes) ->
              do return (q)
                 let l = 0
                 let z = 2
                 let ba = (maximumprimes - 1)
                 let y k bg =
                       (if (k <= ba)
                       then do bh <- ifM (((==) <$> (readIOA era k) <*> return (k)))
                                         (do writeIOA primes bg k
                                             let bi = (bg + 1)
                                             return (bi))
                                         (return (bg))
                               (y (k + 1) bh)
                       else do printf "%d" (bg :: Int)::IO()
                               printf " == " ::IO()
                               printf "%d" (nprimes :: Int)::IO()
                               printf "\n" ::IO()
                               ((\ (s, sum) ->
                                  do return (s)
                                     let maxl = 0
                                     let process = True
                                     let stop = (maximumprimes - 1)
                                     let len = 1
                                     let resp = 1
                                     let u bj bk bl bm bn =
                                           (if bl
                                           then do let bo = False
                                                   let w = 0
                                                   let x = bn
                                                   let v i bp bq br bs =
                                                         (if (i <= x)
                                                         then ((\ (bt, bu, bv, bw) ->
                                                                 (v (i + 1) bt bu bv bw)) =<< (if ((i + bj) < nprimes)
                                                                                              then do writeIOA sum i =<< ((+) <$> (readIOA sum i) <*> (readIOA primes (i + bj)))
                                                                                                      ((\ (bx, by, bz, ca) ->
                                                                                                         return ((bx, by, bz, ca))) =<< ifM ((((>) maximumprimes) <$> (readIOA sum i)))
                                                                                                                                            (do let cb = True
                                                                                                                                                ((\ (cc, cd) ->
                                                                                                                                                   return ((cc, cb, cd, bs))) =<< ifM (((==) <$> join (readIOA era <$> (readIOA sum i)) <*> (readIOA sum i)))
                                                                                                                                                                                      (do let ce = bj
                                                                                                                                                                                          cf <- (readIOA sum i)
                                                                                                                                                                                          return ((ce, cf)))
                                                                                                                                                                                      (return ((bp, br)))))
                                                                                                                                            (do cg <- (min2_ bs i)
                                                                                                                                                return ((bp, bq, br, cg))))
                                                                                              else return ((bp, bq, br, bs))))
                                                         else do let ch = (bj + 1)
                                                                 (u ch bp bq br bs)) in
                                                         (v w bk bo bm bn)
                                           else do printf "%d" (bm :: Int)::IO()
                                                   printf "\n" ::IO()
                                                   printf "%d" (bk :: Int)::IO()
                                                   printf "\n" ::IO()) in
                                           (u len maxl process resp stop)) =<< (array_init_withenv nprimes (\ i_ () ->
                                                                                                             do r <- (readIOA primes i_)
                                                                                                                return (((), r))) ()))) in
                       (y z l)) =<< (array_init_withenv nprimes (\ o () ->
                                                                  let p = 0
                                                                          in return (((), p))) ()))) =<< (array_init_withenv maximumprimes (\ j () ->
                                                                                                                                             let h = j
                                                                                                                                                     in return (((), h))) ()))

