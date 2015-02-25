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
                                                                                                                                 

min2_ a b =
  return (if a < b
          then a
          else b)



pathfind_aux cache tab x y posX posY =
  if posX == x - 1 && posY == y - 1
  then return 0
  else if posX < 0 || posY < 0 || posX >= x || posY >= y
       then return (x * y * 10)
       else ifM (((==) '#') <$> (join $ readIOA <$> (readIOA tab posY) <*> return posX))
                (return (x * y * 10))
                (ifM (((/=) (- 1)) <$> (join $ readIOA <$> (readIOA cache posY) <*> return posX))
                     (join $ readIOA <$> (readIOA cache posY) <*> return posX)
                     (do (join $ writeIOA <$> (readIOA cache posY) <*> return posX <*> return (x * y * 10))
                         val1 <- (pathfind_aux cache tab x y (posX + 1) posY)
                         val2 <- (pathfind_aux cache tab x y (posX - 1) posY)
                         val3 <- (pathfind_aux cache tab x y posX (posY - 1))
                         val4 <- (pathfind_aux cache tab x y posX (posY + 1))
                         out0 <- (((+) 1) <$> (join $ min2_ <$> (join $ min2_ <$> (min2_ val1 val2) <*> return val3) <*> return val4))
                         (join $ writeIOA <$> (readIOA cache posY) <*> return posX <*> return out0)
                         return out0))

pathfind tab x y =
  ((array_init_withenv y (\ i h ->
                           ((array_init_withenv x (\ j l ->
                                                    do printf "%c" =<< ((join $ readIOA <$> (readIOA tab i) <*> return j) :: IO Char)
                                                       let k = - 1
                                                       return ((), k)) ()) >>= (\ (l, tmp) ->
                                                                                 do printf "\n" :: IO ()
                                                                                    let g = tmp
                                                                                    return ((), g)))) ()) >>= (\ (h, cache) ->
                                                                                                                (pathfind_aux cache tab x y 0 0)))

main =
  do x <- (fmap read getLine)
     y <- (fmap read getLine)
     printf "%d" (x :: Int) :: IO ()
     printf " " :: IO ()
     printf "%d" (y :: Int) :: IO ()
     printf "\n" :: IO ()
     ((array_init_withenv y (\ f o ->
                              do m <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return x)) <*> getLine))
                                 return ((), m)) ()) >>= (\ (o, e) ->
                                                           do let tab = e
                                                              result <- (pathfind tab x y)
                                                              printf "%d" (result :: Int) :: IO ()))


