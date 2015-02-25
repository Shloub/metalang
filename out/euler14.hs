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
                                                                                                                                                                                                                                                                         

next0 n =
  return (if (n `rem` 2) == 0
          then n `quot` 2
          else 3 * n + 1)

find n m =
  if n == 1
  then return 1
  else if n >= 1000000
       then (((+) 1) <$> (join $ find <$> (next0 n) <*> return m))
       else ifM (((/=) 0) <$> (readIOA m n))
                (readIOA m n)
                (do (writeIOA m n =<< (((+) 1) <$> (join $ find <$> (next0 n) <*> return m)))
                    (readIOA m n))

main =
  ((array_init_withenv 1000000 (\ j b ->
                                 let a = 0
                                         in return ((), a)) ()) >>= (\ (b, m) ->
                                                                      do let max0 = 0
                                                                         let maxi = 0
                                                                         let c i d e =
                                                                               if i <= 999
                                                                               then {- normalement on met 999999 mais ça dépasse les int32... -}
                                                                                    do n2 <- (find i m)
                                                                                       if n2 > d
                                                                                       then do let f = n2
                                                                                               let g = i
                                                                                               (c (i + 1) f g)
                                                                                       else (c (i + 1) d e)
                                                                               else do printf "%d" (d :: Int) :: IO ()
                                                                                       printf "\n" :: IO ()
                                                                                       printf "%d" (e :: Int) :: IO ()
                                                                                       printf "\n" :: IO () in
                                                                               (c 1 max0 maxi)))


