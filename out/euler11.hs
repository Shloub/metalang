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



max2_ a b =
  return ((if (a > b)
          then a
          else b))
find n m x y dx dy =
  (if ((((x < 0) || (x == 20)) || (y < 0)) || (y == 20))
  then return ((- 1))
  else (if (n == 0)
       then return (1)
       else ((*) <$> join (readIOA <$> (readIOA m y) <*> return (x)) <*> (find (n - 1) m (x + dx) (y + dy) dx dy))))
main =
  ((\ (k, directions) ->
     do let max0 = 0
        let c = 20
        ((\ (o, m) ->
           let p j v =
                 (if (j <= 7)
                 then ((\ (dx, dy) ->
                         let q x w =
                               (if (x <= 19)
                               then let r y ba =
                                          (if (y <= 19)
                                          then do bb <- (max2_ ba =<< (find 4 m x y dx dy))
                                                  (r (y + 1) bb)
                                          else (q (x + 1) ba)) in
                                          (r 0 w)
                               else (p (j + 1) w)) in
                               (q 0 v)) =<< (readIOA directions j))
                 else do printf "%d" (v :: Int)::IO()
                         printf "\n" ::IO()) in
                 (p 0 max0)) =<< (array_init_withenv 20 (\ d o ->
                                                          ((\ (u, f) ->
                                                             let l = f
                                                                     in return (((), l))) =<< (array_init_withenv c (\ g u ->
                                                                                                                      do e <- read_int
                                                                                                                         skip_whitespaces
                                                                                                                         let s = e
                                                                                                                         return (((), s))) ()))) ()))) =<< (array_init_withenv 8 (\ i k ->
                                                                                                                                                                                   return ((if (i == 0)
                                                                                                                                                                                           then let h = (0, 1)
                                                                                                                                                                                                        in ((), h)
                                                                                                                                                                                           else (if (i == 1)
                                                                                                                                                                                                then let h = (1, 0)
                                                                                                                                                                                                             in ((), h)
                                                                                                                                                                                                else (if (i == 2)
                                                                                                                                                                                                     then let h = (0, (- 1))
                                                                                                                                                                                                                  in ((), h)
                                                                                                                                                                                                     else (if (i == 3)
                                                                                                                                                                                                          then let h = ((- 1), 0)
                                                                                                                                                                                                                       in ((), h)
                                                                                                                                                                                                          else (if (i == 4)
                                                                                                                                                                                                               then let h = (1, 1)
                                                                                                                                                                                                                            in ((), h)
                                                                                                                                                                                                               else (if (i == 5)
                                                                                                                                                                                                                    then let h = (1, (- 1))
                                                                                                                                                                                                                                 in ((), h)
                                                                                                                                                                                                                    else (if (i == 6)
                                                                                                                                                                                                                         then let h = ((- 1), 1)
                                                                                                                                                                                                                                      in ((), h)
                                                                                                                                                                                                                         else let h = ((- 1), (- 1))
                                                                                                                                                                                                                                      in ((), h)))))))))) ()))

