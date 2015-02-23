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



periode restes len a b =
  let c o q =
        (if (o /= 0)
        then do let chiffre = (o `quot` b)
                let reste = (o `rem` b)
                let e = 0
                let f = (q - 1)
                let d i =
                      (if (i <= f)
                      then ifM (((==) <$> (readIOA restes i) <*> return (reste)))
                               (return ((q - i)))
                               ((d (i + 1)))
                      else do writeIOA restes q reste
                              let r = (q + 1)
                              let s = (reste * 10)
                              (c s r)) in
                      (d e)
        else return (0)) in
        (c a len)
main =
  ((\ (h, t) ->
     do return (h)
        let m = 0
        let mi = 0
        let l = 1
        let n = 1000
        let k i u v =
              (if (i <= n)
              then do p <- (periode t 0 1 i)
                      ((\ (w, x) ->
                         (k (i + 1) w x)) (if (p > u)
                                          then let y = i
                                                       in let z = p
                                                                  in (z, y)
                                          else (u, v)))
              else do printf "%d" (v :: Int)::IO()
                      printf "\n" ::IO()
                      printf "%d" (u :: Int)::IO()
                      printf "\n" ::IO()) in
              (k l m mi)) =<< (array_init_withenv 1000 (\ j () ->
                                                         let g = 0
                                                                 in return (((), g))) ()))

