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



max2_ a b =
  return ((if (a > b)
          then a
          else b))
main =
  do let i = 1
     ((\ (h, last) ->
        do let m = h
           let max0 = m
           let index = 0
           let nskipdiv = 0
           let l k n o p q =
                 (if (k <= 995)
                 then hGetChar stdin >>= ((\ e ->
                                            do f <- ((-) <$> ((fmap ord (return (e)))) <*> ((fmap ord (return ('0')))))
                                               ((\ (r, s) ->
                                                  do writeIOA last o f
                                                     let t = ((o + 1) `rem` 5)
                                                     u <- (max2_ p r)
                                                     (l (k + 1) r t u s)) =<< (if (f == 0)
                                                                              then let v = 1
                                                                                           in let w = 4
                                                                                                      in return ((v, w))
                                                                              else do let x = (n * f)
                                                                                      y <- (if (q < 0)
                                                                                           then do z <- ((quot x) <$> (readIOA last o))
                                                                                                   return (z)
                                                                                           else return (x))
                                                                                      let ba = (q - 1)
                                                                                      return ((y, ba))))))
                 else do printf "%d" (p :: Int)::IO()
                         printf "\n" ::IO()) in
                 (l 1 m index max0 nskipdiv)) =<< (array_init_withenv 5 (\ j bb ->
                                                                          hGetChar stdin >>= ((\ c ->
                                                                                                do d <- ((-) <$> ((fmap ord (return (c)))) <*> ((fmap ord (return ('0')))))
                                                                                                   let bc = (bb * d)
                                                                                                   let g = d
                                                                                                   return ((bc, g))))) i))

