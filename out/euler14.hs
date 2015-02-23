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



next0 n =
  return ((if ((n `rem` 2) == 0)
          then (n `quot` 2)
          else ((3 * n) + 1)))
find n m =
  (if (n == 1)
  then return (1)
  else (if (n >= 1000000)
       then (((+) 1) <$> (join (find <$> (next0 n) <*> (return m))))
       else ifM (((/=) <$> (readIOA m n) <*> return (0)))
                ((readIOA m n))
                (do writeIOA m n =<< (((+) 1) <$> (join (find <$> (next0 n) <*> (return m))))
                    (readIOA m n))))
main =
  ((\ (b, m) ->
     do return (b)
        let max0 = 0
        let maxi = 0
        let c i d e =
              (if (i <= 999)
              then {- normalement on met 999999 mais ça dépasse les int32... -}
                   do n2 <- (find i m)
                      (if (n2 > d)
                      then do let f = n2
                              let g = i
                              (c (i + 1) f g)
                      else (c (i + 1) d e))
              else do printf "%d" (d :: Int)::IO()
                      printf "\n" ::IO()
                      printf "%d" (e :: Int)::IO()
                      printf "\n" ::IO()) in
              (c 1 max0 maxi)) =<< (array_init_withenv 1000000 (\ j () ->
                                                                 let a = 0
                                                                         in return (((), a))) ()))

