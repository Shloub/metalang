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
     do return (h)
        let sum = 0
        let bc = 0
        let bd = 9
        let j a be =
              (if (a <= bd)
              then do let ba = 0
                      let bb = 9
                      let k b bf =
                            (if (b <= bb)
                            then do let y = 0
                                    let z = 9
                                    let l c bg =
                                          (if (c <= z)
                                          then do let w = 0
                                                  let x = 9
                                                  let m d bh =
                                                        (if (d <= x)
                                                        then do let u = 0
                                                                let v = 9
                                                                let n e bi =
                                                                      (if (e <= v)
                                                                      then do let q = 0
                                                                              let t = 9
                                                                              let o f bj =
                                                                                    (if (f <= t)
                                                                                    then do s <- ((+) <$> ((+) <$> ((+) <$> ((+) <$> ((+) <$> (readIOA p a) <*> (readIOA p b)) <*> (readIOA p c)) <*> (readIOA p d)) <*> (readIOA p e)) <*> (readIOA p f))
                                                                                            let r = (((((a + (b * 10)) + (c * 100)) + (d * 1000)) + (e * 10000)) + (f * 100000))
                                                                                            bk <- (if ((s == r) && (r /= 1))
                                                                                                  then do printf "%d" (f :: Int)::IO()
                                                                                                          printf "%d" (e :: Int)::IO()
                                                                                                          printf "%d" (d :: Int)::IO()
                                                                                                          printf "%d" (c :: Int)::IO()
                                                                                                          printf "%d" (b :: Int)::IO()
                                                                                                          printf "%d" (a :: Int)::IO()
                                                                                                          printf " " ::IO()
                                                                                                          printf "%d" (r :: Int)::IO()
                                                                                                          printf "\n" ::IO()
                                                                                                          let bl = (bj + r)
                                                                                                          return (bl)
                                                                                                  else return (bj))
                                                                                            (o (f + 1) bk)
                                                                                    else (n (e + 1) bj)) in
                                                                                    (o q bi)
                                                                      else (m (d + 1) bi)) in
                                                                      (n u bh)
                                                        else (l (c + 1) bh)) in
                                                        (m w bg)
                                          else (k (b + 1) bg)) in
                                          (l y bf)
                            else (j (a + 1) bf)) in
                            (k ba be)
              else printf "%d" (be :: Int)::IO()) in
              (j bc sum)) =<< (array_init_withenv 10 (\ i () ->
                                                       let g = ((((i * i) * i) * i) * i)
                                                               in return (((), g))) ()))

