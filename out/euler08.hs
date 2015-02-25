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
                                                                                                                                                                                                                                                                         


max2_ a b =
  return (if a > b
          then a
          else b)

main =
  do let i = 1
     ((array_init_withenv 5 (\ j bb ->
                              hGetChar stdin >>= ((\ c ->
                                                    do d <- ((-) <$> ((fmap ord (return c))) <*> ((fmap ord (return '0'))))
                                                       let bc = bb * d
                                                       let g = d
                                                       return (bc, g)))) i) >>= (\ (m, last) ->
                                                                                  do let max0 = m
                                                                                     let index = 0
                                                                                     let nskipdiv = 0
                                                                                     let l k n o p q =
                                                                                           if k <= 995
                                                                                           then hGetChar stdin >>= ((\ e ->
                                                                                                                      do f <- ((-) <$> ((fmap ord (return e))) <*> ((fmap ord (return '0'))))
                                                                                                                         ((if f == 0
                                                                                                                           then let v = 1
                                                                                                                                        in let w = 4
                                                                                                                                                   in return (v, w)
                                                                                                                           else do let x = n * f
                                                                                                                                   y <- if q < 0
                                                                                                                                        then do z <- ((quot x) <$> (readIOA last o))
                                                                                                                                                return z
                                                                                                                                        else return x
                                                                                                                                   let ba = q - 1
                                                                                                                                   return (y, ba)) >>= (\ (r, s) ->
                                                                                                                                                         do (writeIOA last o f)
                                                                                                                                                            let t = (o + 1) `rem` 5
                                                                                                                                                            u <- (max2_ p r)
                                                                                                                                                            (l (k + 1) r t u s)))))
                                                                                           else do printf "%d" (p :: Int) :: IO ()
                                                                                                   printf "\n" :: IO () in
                                                                                           (l 1 m index max0 nskipdiv)))


