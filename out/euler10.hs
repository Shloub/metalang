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



eratostene t max0 =
  do let sum = 0
     let c = 2
     let d = (max0 - 1)
     let a i g =
           (if (i <= d)
           then do h <- ifM (((==) <$> (readIOA t i) <*> return (i)))
                            (do let k = (g + i)
                                (if ((max0 `quot` i) > i)
                                then do let j = (i * i)
                                        let b l =
                                              (if ((l < max0) && (l > 0))
                                              then do writeIOA t l 0
                                                      let m = (l + i)
                                                      (b m)
                                              else return (())) in
                                              (b j)
                                else return (()))
                                return (k))
                            (return (g))
                   (a (i + 1) h)
           else return (g)) in
           (a c sum)
main =
  do let n = 100000
     {- normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages -}
     ((\ (f, t) ->
        do return (f)
           writeIOA t 1 0
           printf "%d" =<< ((eratostene t n) :: IO Int)
           printf "\n" ::IO()) =<< (array_init_withenv n (\ i () ->
                                                           let e = i
                                                                   in return (((), e))) ()))
