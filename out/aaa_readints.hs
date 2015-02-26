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
                                                            



main =
  do len <- (fmap read getLine)
     printf "%d" (len :: Int) :: IO ()
     printf "=len\n" :: IO ()
     tab1 <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
     let k = len - 1
     let h i =
           if i <= k
           then do printf "%d" (i :: Int) :: IO ()
                   printf "=>" :: IO ()
                   printf "%d" =<< (readIOA tab1 i :: IO Int)
                   printf "\n" :: IO ()
                   h (i + 1)
           else do l <- (fmap read getLine)
                   (array_init_withenv (l - 1) (\ a c ->
                                                 do b <- (join (newListArray . (,) 0 . subtract 1 <$> return l <*> fmap (map read . words) getLine))
                                                    return ((), b)) ()) >>= (\ (c, tab2) ->
                                                                              do let g = l - 2
                                                                                 let d m =
                                                                                       if m <= g
                                                                                       then do let f = l - 1
                                                                                               let e j =
                                                                                                     if j <= f
                                                                                                     then do printf "%d" =<< (join $ readIOA <$> (readIOA tab2 m) <*> return j :: IO Int)
                                                                                                             printf " " :: IO ()
                                                                                                             e (j + 1)
                                                                                                     else do printf "\n" :: IO ()
                                                                                                             d (m + 1) in
                                                                                                     e 0
                                                                                       else return () in
                                                                                       d 0) in
           h 0


