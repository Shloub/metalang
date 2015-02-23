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



divisible n t size =
  do let c = (size - 1)
     let b i =
           (if (i <= c)
           then ifM (((==) <$> ((rem n) <$> (readIOA t i)) <*> return (0)))
                    (return (True))
                    ((b (i + 1)))
           else return (False)) in
           (b 0)
find n t used nth =
  let a f g =
        (if (g /= nth)
        then ifM ((divisible f t g))
                 (do let h = (f + 1)
                     (a h g))
                 (do writeIOA t g f
                     let j = (f + 1)
                     let k = (g + 1)
                     (a j k))
        else (readIOA t (g - 1))) in
        (a n used)
main =
  do let n = 10001
     ((\ (e, t) ->
        do return (e)
           printf "%d" =<< ((find 3 t 1 n) :: IO Int)
           printf "\n" ::IO()) =<< (array_init_withenv n (\ i () ->
                                                           let d = 2
                                                                   in return (((), d))) ()))

