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



main =
  {-
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
-}
  ((\ (h, p) ->
     do let sum = 0
        let j a q =
              (if (a <= 9)
              then let k b t =
                         (if (b <= 9)
                         then let l c u =
                                    (if (c <= 9)
                                    then let m d v =
                                               (if (d <= 9)
                                               then let n e w =
                                                          (if (e <= 9)
                                                          then let o f x =
                                                                     (if (f <= 9)
                                                                     then do s <- ((+) <$> ((+) <$> ((+) <$> ((+) <$> ((+) <$> (readIOA p a) <*> (readIOA p b)) <*> (readIOA p c)) <*> (readIOA p d)) <*> (readIOA p e)) <*> (readIOA p f))
                                                                             let r = (((((a + (b * 10)) + (c * 100)) + (d * 1000)) + (e * 10000)) + (f * 100000))
                                                                             (if ((s == r) && (r /= 1))
                                                                             then do printf "%d" (f :: Int)::IO()
                                                                                     printf "%d" (e :: Int)::IO()
                                                                                     printf "%d" (d :: Int)::IO()
                                                                                     printf "%d" (c :: Int)::IO()
                                                                                     printf "%d" (b :: Int)::IO()
                                                                                     printf "%d" (a :: Int)::IO()
                                                                                     printf " " ::IO()
                                                                                     printf "%d" (r :: Int)::IO()
                                                                                     printf "\n" ::IO()
                                                                                     let y = (x + r)
                                                                                     (o (f + 1) y)
                                                                             else (o (f + 1) x))
                                                                     else (n (e + 1) x)) in
                                                                     (o 0 w)
                                                          else (m (d + 1) w)) in
                                                          (n 0 v)
                                               else (l (c + 1) v)) in
                                               (m 0 u)
                                    else (k (b + 1) u)) in
                                    (l 0 t)
                         else (j (a + 1) t)) in
                         (k 0 q)
              else printf "%d" (q :: Int)::IO()) in
              (j 0 sum)) =<< (array_init_withenv 10 (\ i h ->
                                                      let g = ((((i * i) * i) * i) * i)
                                                              in return (((), g))) ()))

