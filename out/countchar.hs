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
                                                                                                                                                                                                                                                                         

nth tab tofind len =
  do let out0 = 0
     let b = (len - 1)
     let a i h =
           (if (i <= b)
           then ifM (((==) <$> (readIOA tab i) <*> return (tofind)))
                    (do let j = (h + 1)
                        (a (i + 1) j))
                    ((a (i + 1) h))
           else return (h)) in
           (a 0 out0)

main =
  do let len = 0
     g <- read_int
     let k = g
     skip_whitespaces
     let tofind = '\000'
     hGetChar stdin >>= ((\ f ->
                           do let l = f
                              skip_whitespaces
                              ((\ (d, tab) ->
                                 do result <- (nth tab l k)
                                    printf "%d" (result :: Int)::IO()) =<< (array_init_withenv k (\ i d ->
                                                                                                   do let tmp = '\000'
                                                                                                      hGetChar stdin >>= ((\ e ->
                                                                                                                            let m = e
                                                                                                                                    in let c = m
                                                                                                                                               in return (((), c))))) ()))))


