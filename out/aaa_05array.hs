import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

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
                                                                                                                                          

id0 b =
  return (b)

g t index =
  writeIOA t index False

main =
  do let j = 0
     ((\ (h, a) ->
        do printf "%d" (h :: Int)::IO()
           printf " " ::IO()
           c <- (readIOA a 0)
           (if c
           then printf "True" ::IO()
           else printf "False" ::IO())
           printf "\n" ::IO()
           (join (g <$> (id0 a) <*> (return 0)))
           d <- (readIOA a 0)
           (if d
           then printf "True" ::IO()
           else printf "False" ::IO())
           printf "\n" ::IO()) =<< (array_init_withenv 5 (\ i k ->
                                                           do printf "%d" (i :: Int)::IO()
                                                              let l = (k + i)
                                                              let e = ((i `rem` 2) == 0)
                                                              return ((l, e))) j))


