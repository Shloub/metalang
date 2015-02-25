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
                                                                                                                                 



result len tab =
  ((array_init_withenv len (\ i b ->
                             let a = False
                                     in return ((), a)) ()) >>= (\ (b, tab2) ->
                                                                  do let f = len - 1
                                                                     let e i1 =
                                                                           if i1 <= f
                                                                           then do printf "%d" =<< ((readIOA tab i1) :: IO Int)
                                                                                   printf " " :: IO ()
                                                                                   (join $ writeIOA tab2 <$> (readIOA tab i1) <*> return True)
                                                                                   (e (i1 + 1))
                                                                           else do printf "\n" :: IO ()
                                                                                   let d = len - 1
                                                                                   let c i2 =
                                                                                         if i2 <= d
                                                                                         then ifM (fmap not (readIOA tab2 i2))
                                                                                                  (return i2)
                                                                                                  (c (i2 + 1))
                                                                                         else return (- 1) in
                                                                                         (c 0) in
                                                                           (e 0)))

main =
  do len <- (fmap read getLine)
     printf "%d" (len :: Int) :: IO ()
     printf "\n" :: IO ()
     tab <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
     printf "%d" =<< ((result len tab) :: IO Int)
     printf "\n" :: IO ()


