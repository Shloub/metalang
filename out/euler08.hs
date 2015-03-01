import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     (,) env <$> newListArray (0, len - 1) li
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)

main :: IO ()

max2_ a b =
  return (if a > b
          then a
          else b)

main =
  (array_init_withenv 5 (\ j bb ->
                           do c <- getChar
                              let d = (ord c) - (ord '0')
                              let bc = bb * d
                              return (bc, d)) 1) >>= (\ (m, last) ->
                                                       let l k n o p q =
                                                             if k <= 995
                                                             then do e <- getChar
                                                                     let f = (ord e) - (ord '0')
                                                                     (if f == 0
                                                                      then return (1, 4)
                                                                      else do let x = n * f
                                                                              y <- if q < 0
                                                                                   then do z <- ((quot x) <$> (readIOA last o))
                                                                                           return z
                                                                                   else return x
                                                                              let ba = q - 1
                                                                              return (y, ba)) >>= (\ (r, s) ->
                                                                                                    do writeIOA last o f
                                                                                                       let t = (o + 1) `rem` 5
                                                                                                       u <- max2_ p r
                                                                                                       l (k + 1) r t u s)
                                                             else printf "%d\n" (p::Int) :: IO() in
                                                             l 1 m 0 m 0)


