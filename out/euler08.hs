import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
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


main =
  (array_init_withenv 5 (\ j g ->
                           do c <- getChar
                              let d = (ord c) - (ord '0')
                              let h = g * d
                              return (h, d)) 1) >>= (\ (l, last) ->
                                                      let m k n o p q =
                                                            if k <= 995
                                                            then do e <- getChar
                                                                    let f = (ord e) - (ord '0')
                                                                    (if f == 0
                                                                     then return (1, 4)
                                                                     else do let r = n * f
                                                                             s <- if q < 0
                                                                                  then ((quot r) <$> (readIOA last o))
                                                                                  else return r
                                                                             let t = q - 1
                                                                             return (s, t)) >>= (\ (u, v) ->
                                                                                                  do writeIOA last o f
                                                                                                     let w = (o + 1) `rem` 5
                                                                                                     let x = (max p u)
                                                                                                     m (k + 1) u w x v)
                                                            else printf "%d\n" (p::Int) :: IO() in
                                                            m 1 l 0 l 0)


