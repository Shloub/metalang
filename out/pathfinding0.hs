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



min2_ a b =
  return ((if (a < b)
          then a
          else b))
pathfind_aux cache tab x y posX posY =
  (if ((posX == (x - 1)) && (posY == (y - 1)))
  then return (0)
  else (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
       then return (((x * y) * 10))
       else ifM (((==) <$> join (readIOA <$> (readIOA tab posY) <*> return (posX)) <*> return ('#')))
                (return (((x * y) * 10)))
                (ifM (((/=) <$> join (readIOA <$> (readIOA cache posY) <*> return (posX)) <*> return ((- 1))))
                     (join (readIOA <$> (readIOA cache posY) <*> return (posX)))
                     (do join (writeIOA <$> (readIOA cache posY) <*> return (posX) <*> return (((x * y) * 10)))
                         val1 <- (pathfind_aux cache tab x y (posX + 1) posY)
                         val2 <- (pathfind_aux cache tab x y (posX - 1) posY)
                         val3 <- (pathfind_aux cache tab x y posX (posY - 1))
                         val4 <- (pathfind_aux cache tab x y posX (posY + 1))
                         out0 <- (((+) 1) <$> (join (min2_ <$> (join (min2_ <$> (min2_ val1 val2) <*> (return val3))) <*> (return val4))))
                         join (writeIOA <$> (readIOA cache posY) <*> return (posX) <*> return (out0))
                         return (out0)))))
pathfind tab x y =
  ((\ (m, cache) ->
     do return (m)
        (pathfind_aux cache tab x y 0 0)) =<< (array_init_withenv y (\ i () ->
                                                                      ((\ (p, tmp) ->
                                                                         do return (p)
                                                                            printf "\n" ::IO()
                                                                            let l = tmp
                                                                            return (((), l))) =<< (array_init_withenv x (\ j () ->
                                                                                                                          do printf "%c" =<< (join (readIOA <$> (readIOA tab i) <*> return (j)) :: IO Char)
                                                                                                                             let o = (- 1)
                                                                                                                             return (((), o))) ()))) ()))
main =
  do x <- read_int
     skip_whitespaces
     y <- read_int
     skip_whitespaces
     printf "%d" (x :: Int)::IO()
     printf " " ::IO()
     printf "%d" (y :: Int)::IO()
     printf "\n" ::IO()
     ((\ (r, e) ->
        do return (r)
           let tab = e
           result <- (pathfind tab x y)
           printf "%d" (result :: Int)::IO()) =<< (array_init_withenv y (\ f () ->
                                                                          ((\ (u, h) ->
                                                                             do return (u)
                                                                                skip_whitespaces
                                                                                let q = h
                                                                                return (((), q))) =<< (array_init_withenv x (\ k () ->
                                                                                                                              hGetChar stdin >>= ((\ g ->
                                                                                                                                                    let s = g
                                                                                                                                                            in return (((), s))))) ()))) ()))

