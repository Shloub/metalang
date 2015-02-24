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
                                                                                                                                                                                                                                                                        

go0 tab a b =
  do let m = ((a + b) `quot` 2)
     (if (a == m)
     then ifM (((==) <$> (readIOA tab a) <*> return (m)))
              (return (b))
              (return (a))
     else do let i = a
             let j = b
             let c k l =
                   (if (k < l)
                   then do e <- (readIOA tab k)
                           (if (e < m)
                           then do let n = (k + 1)
                                   (c n l)
                           else do let o = (l - 1)
                                   writeIOA tab k =<< (readIOA tab o)
                                   writeIOA tab o e
                                   (c k o))
                   else (if (k < m)
                        then (go0 tab a m)
                        else (go0 tab m b))) in
                   (c i j))

plus_petit0 tab len =
  (go0 tab 0 len)

main =
  do let len = 0
     h <- read_int
     let p = h
     skip_whitespaces
     ((\ (f, tab) ->
        printf "%d" =<< ((plus_petit0 tab p) :: IO Int)) =<< (array_init_withenv p (\ i f ->
                                                                                     do let tmp = 0
                                                                                        g <- read_int
                                                                                        let q = g
                                                                                        skip_whitespaces
                                                                                        let d = q
                                                                                        return (((), d))) ()))


