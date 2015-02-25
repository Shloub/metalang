import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False
(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

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
                                      then do (writeIOA t y 0)
                                              let z = y + i
                                              (d z)
                                      else (c (i + 1) x) in
                                      (d j)
                        else (c (i + 1) x))
                    (c (i + 1) w)
           else return w in
           (c 2 n)

main =
  do let maximumprimes = 1000001
     ((array_init_withenv maximumprimes (\ j g ->
                                          let f = j
                                                  in return ((), f)) ()) >>= (\ (g, era) ->
                                                                               do nprimes <- (eratostene era maximumprimes)
                                                                                  ((array_init_withenv nprimes (\ o m ->
                                                                                                                 let h = 0
                                                                                                                         in return ((), h)) ()) >>= (\ (m, primes) ->
                                                                                                                                                      do let l = 0
                                                                                                                                                         let v = maximumprimes - 1
                                                                                                                                                         let u k ba =
                                                                                                                                                               if k <= v
                                                                                                                                                               then ifM (((==) k) <$> (readIOA era k))
                                                                                                                                                                        (do (writeIOA primes ba k)
                                                                                                                                                                            let bb = ba + 1
                                                                                                                                                                            (u (k + 1) bb))
                                                                                                                                                                        (u (k + 1) ba)
                                                                                                                                                               else do printf "%d" (ba :: Int) :: IO ()
                                                                                                                                                                       printf " == " :: IO ()
                                                                                                                                                                       printf "%d" (nprimes :: Int) :: IO ()
                                                                                                                                                                       printf "\n" :: IO ()
                                                                                                                                                                       ((array_init_withenv nprimes (\ i_ q ->
                                                                                                                                                                                                      do p <- (readIOA primes i_)
                                                                                                                                                                                                         return ((), p)) ()) >>= (\ (q, sum) ->
                                                                                                                                                                                                                                   do let maxl = 0
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
                                                                                                                                                                                                                                                               then do (writeIOA sum i =<< ((+) <$> (readIOA sum i) <*> (readIOA primes (i + bc))))
                                                                                                                                                                                                                                                                       ifM (((>) maximumprimes) <$> (readIOA sum i))
                                                                                                                                                                                                                                                                           (do let bm = True
                                                                                                                                                                                                                                                                               ifM ((==) <$> (readIOA era =<< (readIOA sum i)) <*> (readIOA sum i))
                                                                                                                                                                                                                                                                                   (do let bn = bc
                                                                                                                                                                                                                                                                                       bo <- (readIOA sum i)
                                                                                                                                                                                                                                                                                       (s (i + 1) bn bm bo bl))
                                                                                                                                                                                                                                                                                   (s (i + 1) bi bm bk bl))
                                                                                                                                                                                                                                                                           (do bp <- (min2_ bl i)
                                                                                                                                                                                                                                                                               (s (i + 1) bi bj bk bp))
                                                                                                                                                                                                                                                               else (s (i + 1) bi bj bk bl)
                                                                                                                                                                                                                                                          else do let bq = bc + 1
                                                                                                                                                                                                                                                                  (r bq bi bj bk bl) in
                                                                                                                                                                                                                                                          (s 0 bd bh bf bg)
                                                                                                                                                                                                                                            else do printf "%d" (bf :: Int) :: IO ()
                                                                                                                                                                                                                                                    printf "\n" :: IO ()
                                                                                                                                                                                                                                                    printf "%d" (bd :: Int) :: IO ()
                                                                                                                                                                                                                                                    printf "\n" :: IO () in
                                                                                                                                                                                                                                            (r len maxl process resp stop))) in
                                                                                                                                                               (u 2 l)))))


