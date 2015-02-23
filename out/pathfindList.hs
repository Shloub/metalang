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



pathfind_aux cache tab len pos =
  (if (pos >= (len - 1))
  then return (0)
  else ifM (((/=) <$> (readIOA cache pos) <*> return ((- 1))))
           ((readIOA cache pos))
           (do writeIOA cache pos (len * 2)
               posval <- (pathfind_aux cache tab len =<< (readIOA tab pos))
               oneval <- (pathfind_aux cache tab len (pos + 1))
               let out0 = 0
               let g = (if (posval < oneval)
                       then let h = (1 + posval)
                                    in h
                       else let j = (1 + oneval)
                                    in j)
               writeIOA cache pos g
               return (g)))
pathfind tab len =
  ((\ (b, cache) ->
     do return (b)
        (pathfind_aux cache tab len 0)) =<< (array_init_withenv len (\ i () ->
                                                                      let a = (- 1)
                                                                              in return (((), a))) ()))
main =
  do let len = 0
     f <- read_int
     let k = f
     skip_whitespaces
     ((\ (d, tab) ->
        do return (d)
           result <- (pathfind tab k)
           printf "%d" (result :: Int)::IO()) =<< (array_init_withenv k (\ i () ->
                                                                          do let tmp = 0
                                                                             e <- read_int
                                                                             let l = e
                                                                             skip_whitespaces
                                                                             let c = l
                                                                             return (((), c))) ()))

