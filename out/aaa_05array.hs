import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef
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
id0 b =
  return b

g t index =
  writeIOA t index False

main =
  (array_init_withenv 5 (\ i c ->
                           do printf "%d" (i :: Int) :: IO ()
                              let d = c + i
                              let e = (i `rem` 2) == 0
                              return (d, e)) 0) >>= (\ (f, a) ->
                                                      do printf "%d " (f::Int) :: IO()
                                                         ifM (readIOA a 0)
                                                             (printf "True" :: IO ())
                                                             (printf "False" :: IO ())
                                                         printf "\n" :: IO ()
                                                         join $ g <$> (id0 a) <*> return 0
                                                         ifM (readIOA a 0)
                                                             (printf "True" :: IO ())
                                                             (printf "False" :: IO ())
                                                         printf "\n" :: IO ())


