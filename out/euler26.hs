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
                                                                                                                                                                                                                                                                         

periode restes len a b =
  let c k l =
        (if (k /= 0)
        then do let chiffre = (k `quot` b)
                let reste = (k `rem` b)
                let e = (l - 1)
                let d i =
                      (if (i <= e)
                      then ifM ((==) <$> (readIOA restes i) <*> return reste)
                               (return (l - i))
                               ((d (i + 1)))
                      else do (writeIOA restes l reste)
                              let n = (l + 1)
                              let o = (reste * 10)
                              (c o n)) in
                      (d 0)
        else return 0) in
        (c a len)

main =
  ((array_init_withenv 1000 (\ j g ->
                              let f = 0
                                      in return ((), f)) ()) >>= (\ (g, t) ->
                                                                   do let m = 0
                                                                      let mi = 0
                                                                      let h i q r =
                                                                            (if (i <= 1000)
                                                                            then do p <- (periode t 0 1 i)
                                                                                    (if (p > q)
                                                                                    then do let s = i
                                                                                            let u = p
                                                                                            (h (i + 1) u s)
                                                                                    else (h (i + 1) q r))
                                                                            else do printf "%d" (r :: Int)::IO()
                                                                                    printf "\n" ::IO()
                                                                                    printf "%d" (q :: Int)::IO()
                                                                                    printf "\n" ::IO()) in
                                                                            (h 1 m mi)))


