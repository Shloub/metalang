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



go0 tab a b =
  do let m = ((a + b) `quot` 2)
     (if (a == m)
     then do let f () = do let i = a
                           let j = b
                           let d n o =
                                 (if (n < o)
                                 then do e <- (readIOA tab n)
                                         ((\ (p, q) ->
                                            (d p q)) =<< (if (e < m)
                                                         then let r = (n + 1)
                                                                      in return ((r, o))
                                                         else do let s = (o - 1)
                                                                 writeIOA tab n =<< (readIOA tab s)
                                                                 writeIOA tab s e
                                                                 return ((n, s))))
                                 else do let c () = return (())
                                         (if (n < m)
                                         then (go0 tab a m)
                                         else (go0 tab m b))) in
                                 (d i j)
             ifM (((==) <$> (readIOA tab a) <*> return (m)))
                 (return (b))
                 (return (a))
     else do let i = a
             let j = b
             let d t u =
                   (if (t < u)
                   then do e <- (readIOA tab t)
                           ((\ (v, w) ->
                              (d v w)) =<< (if (e < m)
                                           then let x = (t + 1)
                                                        in return ((x, u))
                                           else do let y = (u - 1)
                                                   writeIOA tab t =<< (readIOA tab y)
                                                   writeIOA tab y e
                                                   return ((t, y))))
                   else do let c () = return (())
                           (if (t < m)
                           then (go0 tab a m)
                           else (go0 tab m b))) in
                   (d i j))
plus_petit0 tab len =
  (go0 tab 0 len)
main =
  do let len = 0
     l <- read_int
     let z = l
     skip_whitespaces
     ((\ (h, tab) ->
        do return (h)
           printf "%d" =<< ((plus_petit0 tab z) :: IO Int)) =<< (array_init_withenv z (\ i () ->
                                                                                        do let tmp = 0
                                                                                           k <- read_int
                                                                                           let ba = k
                                                                                           skip_whitespaces
                                                                                           let g = ba
                                                                                           return (((), g))) ()))

