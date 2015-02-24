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

main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

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
                                                                                                                                                                                                                                                                        

fact n =
  do let prod = 1
     let q i r =
           (if (i <= n)
           then do let s = (r * i)
                   (q (i + 1) s)
           else return (r)) in
           (q 2 prod)

show0 lim nth =
  ((\ (b, t) ->
     ((\ (d, pris) ->
        do let p = (lim - 1)
           let g k u =
                 (if (k <= p)
                 then do n <- (fact (lim - k))
                         let nchiffre = (u `quot` n)
                         let v = (u `rem` n)
                         let o = (lim - 1)
                         let h l w =
                               (if (l <= o)
                               then ifM ((fmap (not) (readIOA pris l)))
                                        (do (if (w == 0)
                                            then do printf "%d" (l :: Int)::IO()
                                                    writeIOA pris l True
                                            else return (()))
                                            let x = (w - 1)
                                            (h (l + 1) x))
                                        ((h (l + 1) w))
                               else (g (k + 1) v)) in
                               (h 0 nchiffre)
                 else do let f = (lim - 1)
                         let e m =
                               (if (m <= f)
                               then ifM ((fmap (not) (readIOA pris m)))
                                        (do printf "%d" (m :: Int)::IO()
                                            (e (m + 1)))
                                        ((e (m + 1)))
                               else printf "\n" ::IO()) in
                               (e 0)) in
                 (g 1 nth)) =<< (array_init_withenv lim (\ j d ->
                                                          let c = False
                                                                  in return (((), c))) ()))) =<< (array_init_withenv lim (\ i b ->
                                                                                                                           let a = i
                                                                                                                                   in return (((), a))) ()))

main =
  do (show0 10 999999)
     return (())


