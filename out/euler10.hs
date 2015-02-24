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
                                                                                                                                                                                                                                                                         

eratostene t max0 =
  do let sum = 0
     let c = (max0 - 1)
     let a i f =
           (if (i <= c)
           then ifM (((==) i) <$> (readIOA t i))
                    (do let g = (f + i)
                        (if ((max0 `quot` i) > i)
                        then do let j = (i * i)
                                let b h =
                                      (if ((h < max0) && (h > 0))
                                      then do (writeIOA t h 0)
                                              let k = (h + i)
                                              (b k)
                                      else (a (i + 1) g)) in
                                      (b j)
                        else (a (i + 1) g)))
                    ((a (i + 1) f))
           else return f) in
           (a 2 sum)

main =
  do let n = 100000
     {- normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages -}
     ((array_init_withenv n (\ i e ->
                              let d = i
                                      in return ((), d)) ()) >>= (\ (e, t) ->
                                                                   do (writeIOA t 1 0)
                                                                      printf "%d" =<< ((eratostene t n) :: IO Int)
                                                                      printf "\n" ::IO()))


