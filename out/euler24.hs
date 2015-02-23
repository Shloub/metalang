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



fact n =
  do let prod = 1
     let v = 2
     let w = n
     let u i x =
           (if (i <= w)
           then do let y = (x * i)
                   (u (i + 1) y)
           else return (x)) in
           (u v prod)
show0 lim nth =
  ((\ (b, t) ->
     do return (b)
        ((\ (d, pris) ->
           do return (d)
              let r = 1
              let s = (lim - 1)
              let h k z =
                    (if (k <= s)
                    then do n <- (fact (lim - k))
                            let nchiffre = (z `quot` n)
                            let ba = (z `rem` n)
                            let p = 0
                            let q = (lim - 1)
                            let o l bb =
                                  (if (l <= q)
                                  then do bc <- ifM ((fmap (not) (readIOA pris l)))
                                                    (do (if (bb == 0)
                                                        then do printf "%d" (l :: Int)::IO()
                                                                writeIOA pris l True
                                                        else return (()))
                                                        let bd = (bb - 1)
                                                        return (bd))
                                                    (return (bb))
                                          (o (l + 1) bc)
                                  else (h (k + 1) ba)) in
                                  (o p nchiffre)
                    else do let f = 0
                            let g = (lim - 1)
                            let e m =
                                  (if (m <= g)
                                  then do ifM ((fmap (not) (readIOA pris m)))
                                              (printf "%d" (m :: Int)::IO())
                                              (return (()))
                                          (e (m + 1))
                                  else printf "\n" ::IO()) in
                                  (e f)) in
                    (h r nth)) =<< (array_init_withenv lim (\ j () ->
                                                             let c = False
                                                                     in return (((), c))) ()))) =<< (array_init_withenv lim (\ i () ->
                                                                                                                              let a = i
                                                                                                                                      in return (((), a))) ()))
main =
  do (show0 10 999999)
     return (())
