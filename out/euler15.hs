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
                                                                                                                                                                                                                                                                         

main =
  do let n = 10
     {- normalement on doit mettre 20 mais là on se tape un overflow -}
     do let w = n + 1
        ((array_init_withenv w (\ i b ->
                                 ((array_init_withenv w (\ j v ->
                                                          let u = 0
                                                                  in return ((), u)) ()) >>= (\ (v, tab2) ->
                                                                                               let a = tab2
                                                                                                       in return ((), a)))) ()) >>= (\ (b, tab) ->
                                                                                                                                      do let t = w - 1
                                                                                                                                         let s l =
                                                                                                                                               if l <= t
                                                                                                                                               then do (join $ writeIOA <$> (readIOA tab (w - 1)) <*> return l <*> return 1)
                                                                                                                                                       (join $ writeIOA <$> (readIOA tab l) <*> return (w - 1) <*> return 1)
                                                                                                                                                       (s (l + 1))
                                                                                                                                               else let g o =
                                                                                                                                                          if o <= w
                                                                                                                                                          then do let r = w - o
                                                                                                                                                                  let h p =
                                                                                                                                                                        if p <= w
                                                                                                                                                                        then do let q = w - p
                                                                                                                                                                                (join $ writeIOA <$> (readIOA tab r) <*> return q <*> ((+) <$> (join $ readIOA <$> (readIOA tab (r + 1)) <*> return q) <*> (join $ readIOA <$> (readIOA tab r) <*> return (q + 1))))
                                                                                                                                                                                (h (p + 1))
                                                                                                                                                                        else (g (o + 1)) in
                                                                                                                                                                        (h 2)
                                                                                                                                                          else do let f = w - 1
                                                                                                                                                                  let c m =
                                                                                                                                                                        if m <= f
                                                                                                                                                                        then do let e = w - 1
                                                                                                                                                                                let d k =
                                                                                                                                                                                      if k <= e
                                                                                                                                                                                      then do printf "%d" =<< ((join $ readIOA <$> (readIOA tab m) <*> return k) :: IO Int)
                                                                                                                                                                                              printf " " :: IO ()
                                                                                                                                                                                              (d (k + 1))
                                                                                                                                                                                      else do printf "\n" :: IO ()
                                                                                                                                                                                              (c (m + 1)) in
                                                                                                                                                                                      (d 0)
                                                                                                                                                                        else do printf "%d" =<< ((join $ readIOA <$> (readIOA tab 0) <*> return 0) :: IO Int)
                                                                                                                                                                                printf "\n" :: IO () in
                                                                                                                                                                        (c 0) in
                                                                                                                                                          (g 2) in
                                                                                                                                               (s 0)))


