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
     let c = 2
     let d = (max0 - 1)
     let a i be =
           (if (i <= d)
           then do bf <- ifM (((==) <$> (readIOA t i) <*> return (i)))
                             (do let bg = (be + 1)
                                 (if ((max0 `quot` i) > i)
                                 then do let j = (i * i)
                                         let b bh =
                                               (if ((bh < max0) && (bh > 0))
                                               then do writeIOA t bh 0
                                                       let bi = (bh + i)
                                                       (b bi)
                                               else return (())) in
                                               (b j)
                                 else return (()))
                                 return (bg))
                             (return (be))
                   (a (i + 1) bf)
           else return (be)) in
           (a c n)
main =
  do let maximumprimes = 6000
     ((\ (f, era) ->
        do return (f)
           nprimes <- (eratostene era maximumprimes)
           ((\ (h, primes) ->
              do return (h)
                 let l = 0
                 let bc = 2
                 let bd = (maximumprimes - 1)
                 let bb k bj =
                        (if (k <= bd)
                        then do bk <- ifM (((==) <$> (readIOA era k) <*> return (k)))
                                          (do writeIOA primes bj k
                                              let bl = (bj + 1)
                                              return (bl))
                                          (return (bj))
                                (bb (k + 1) bk)
                        else do printf "%d" (bj :: Int)::IO()
                                printf " == " ::IO()
                                printf "%d" (nprimes :: Int)::IO()
                                printf "\n" ::IO()
                                ((\ (q, canbe) ->
                                   do return (q)
                                      let z = 0
                                      let ba = (nprimes - 1)
                                      let v i =
                                            (if (i <= ba)
                                            then do let x = 0
                                                    let y = (maximumprimes - 1)
                                                    let w j =
                                                          (if (j <= y)
                                                          then do n <- ((+) <$> (readIOA primes i) <*> return (((2 * j) * j)))
                                                                  (if (n < maximumprimes)
                                                                  then writeIOA canbe n True
                                                                  else return (()))
                                                                  (w (j + 1))
                                                          else (v (i + 1))) in
                                                          (w x)
                                            else do let s = 1
                                                    let u = maximumprimes
                                                    let r m =
                                                          (if (m <= u)
                                                          then do let m2 = ((m * 2) + 1)
                                                                  ifM ((return ((m2 < maximumprimes)) <&&> (fmap (not) (readIOA canbe m2))))
                                                                      (do printf "%d" (m2 :: Int)::IO()
                                                                          printf "\n" ::IO())
                                                                      (return (()))
                                                                  (r (m + 1))
                                                          else return (())) in
                                                          (r s)) in
                                            (v z)) =<< (array_init_withenv maximumprimes (\ i_ () ->
                                                                                           let p = False
                                                                                                   in return (((), p))) ()))) in
                        (bb bc l)) =<< (array_init_withenv nprimes (\ o () ->
                                                                     let g = 0
                                                                             in return (((), g))) ()))) =<< (array_init_withenv maximumprimes (\ j_ () ->
                                                                                                                                                let e = j_
                                                                                                                                                        in return (((), e))) ()))

