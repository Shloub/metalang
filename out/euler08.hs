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
  (array_init_withenv 5 (\ j w ->
                           do c <- getChar
                              let d = (ord c) - (ord '0')
                              let x = w * d
                              return (x, d)) 1) >>= (\ (g, last) ->
                                                      let h k l m n o =
                                                            if k <= 995
                                                            then do e <- getChar
                                                                    let f = (ord e) - (ord '0')
                                                                    (if f == 0
                                                                     then return (1, 4)
                                                                     else do let t = l * f
                                                                             u <- if o < 0
                                                                                  then ((quot t) <$> (readIOA last m))
                                                                                  else return t
                                                                             let v = o - 1
                                                                             return (u, v)) >>= (\ (p, q) ->
                                                                                                  do writeIOA last m f
                                                                                                     let r = (m + 1) `rem` 5
                                                                                                     let s = (max n p)
                                                                                                     h (k + 1) p r s q)
                                                            else printf "%d\n" (n::Int) :: IO() in
                                                            h 1 g 0 g 0)


