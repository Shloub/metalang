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
  if ((x < 0 || x == 20) || y < 0) || y == 20
  then return (- 1)
  else if n == 0
       then return 1
       else ((*) <$> (join $ readIOA <$> (readIOA m y) <*> return x) <*> (find (n - 1) m (x + dx) (y + dy) dx dy))

main =
  (array_init_withenv 8 (\ i e ->
                          return (if i == 0
                                  then let d = (0, 1)
                                               in ((), d)
                                  else if i == 1
                                       then let d = (1, 0)
                                                    in ((), d)
                                       else if i == 2
                                            then let d = (0, - 1)
                                                         in ((), d)
                                            else if i == 3
                                                 then let d = (- 1, 0)
                                                              in ((), d)
                                                 else if i == 4
                                                      then let d = (1, 1)
                                                                   in ((), d)
                                                      else if i == 5
                                                           then let d = (1, - 1)
                                                                        in ((), d)
                                                           else if i == 6
                                                                then let d = (- 1, 1)
                                                                             in ((), d)
                                                                else let d = (- 1, - 1)
                                                                             in ((), d))) ()) >>= (\ (e, directions) ->
                                                                                                    do let max0 = 0
                                                                                                       (array_init_withenv 20 (\ c g ->
                                                                                                                                do f <- (join (newListArray . (,) 0 . subtract 1 <$> return 20 <*> fmap (map read . words) getLine))
                                                                                                                                   return ((), f)) ()) >>= (\ (g, m) ->
                                                                                                                                                             let h j o =
                                                                                                                                                                   if j <= 7
                                                                                                                                                                   then (readIOA directions j) >>= (\ (dx, dy) ->
                                                                                                                                                                                                     let k x p =
                                                                                                                                                                                                           if x <= 19
                                                                                                                                                                                                           then let l y q =
                                                                                                                                                                                                                      if y <= 19
                                                                                                                                                                                                                      then do r <- max2_ q =<< (find 4 m x y dx dy)
                                                                                                                                                                                                                              l (y + 1) r
                                                                                                                                                                                                                      else k (x + 1) q in
                                                                                                                                                                                                                      l 0 p
                                                                                                                                                                                                           else h (j + 1) p in
                                                                                                                                                                                                           k 0 o)
                                                                                                                                                                   else do printf "%d" (o :: Int) :: IO ()
                                                                                                                                                                           printf "\n" :: IO () in
                                                                                                                                                                   h 0 max0))


