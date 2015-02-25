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


find n m x y dx dy =
  if x < 0 || x == 20 || y < 0 || y == 20
  then return (- 1)
  else if n == 0
       then return 1
       else ((*) <$> (join $ readIOA <$> (readIOA m y) <*> return x) <*> (find (n - 1) m (x + dx) (y + dy) dx dy))

main =
  ((array_init_withenv 8 (\ i f ->
                           return (if i == 0
                                   then let e = (0, 1)
                                                in ((), e)
                                   else if i == 1
                                        then let e = (1, 0)
                                                     in ((), e)
                                        else if i == 2
                                             then let e = (0, - 1)
                                                          in ((), e)
                                             else if i == 3
                                                  then let e = (- 1, 0)
                                                               in ((), e)
                                                  else if i == 4
                                                       then let e = (1, 1)
                                                                    in ((), e)
                                                       else if i == 5
                                                            then let e = (1, - 1)
                                                                         in ((), e)
                                                            else if i == 6
                                                                 then let e = (- 1, 1)
                                                                              in ((), e)
                                                                 else let e = (- 1, - 1)
                                                                              in ((), e))) ()) >>= (\ (f, directions) ->
                                                                                                     do let max0 = 0
                                                                                                        let c = 20
                                                                                                        ((array_init_withenv 20 (\ d h ->
                                                                                                                                  do g <- (join (newListArray . (,) 0 . subtract 1 <$> return c <*> fmap (map read . words) getLine))
                                                                                                                                     return ((), g)) ()) >>= (\ (h, m) ->
                                                                                                                                                               let k j p =
                                                                                                                                                                     if j <= 7
                                                                                                                                                                     then ((readIOA directions j) >>= (\ (dx, dy) ->
                                                                                                                                                                                                        let l x q =
                                                                                                                                                                                                              if x <= 19
                                                                                                                                                                                                              then let o y r =
                                                                                                                                                                                                                         if y <= 19
                                                                                                                                                                                                                         then do s <- (max2_ r =<< (find 4 m x y dx dy))
                                                                                                                                                                                                                                 (o (y + 1) s)
                                                                                                                                                                                                                         else (l (x + 1) r) in
                                                                                                                                                                                                                         (o 0 q)
                                                                                                                                                                                                              else (k (j + 1) q) in
                                                                                                                                                                                                              (l 0 p)))
                                                                                                                                                                     else do printf "%d" (p :: Int) :: IO ()
                                                                                                                                                                             printf "\n" :: IO () in
                                                                                                                                                                     (k 0 max0)))))


