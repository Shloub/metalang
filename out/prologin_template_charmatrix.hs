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
                                                            




programme_candidat tableau taille_x taille_y =
  do let out0 = 0
     let f = taille_y - 1
     let c i k =
           if i <= f
           then do let e = taille_x - 1
                   let d j l =
                         if j <= e
                         then do m <- (((+) l) <$> (((*) (i + j * 2)) <$> ((fmap ord ((join $ readIOA <$> (readIOA tableau i) <*> return j))))))
                                 printf "%c" =<< ((join $ readIOA <$> (readIOA tableau i) <*> return j) :: IO Char)
                                 (d (j + 1) m)
                         else do printf "--\n" :: IO ()
                                 (c (i + 1) l) in
                         (d 0 k)
           else return k in
           (c 0 out0)

main =
  do taille_x <- (fmap read getLine)
     taille_y <- (fmap read getLine)
     ((array_init_withenv taille_y (\ b h ->
                                     do g <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return taille_x)) <*> getLine))
                                        return ((), g)) ()) >>= (\ (h, a) ->
                                                                  do let tableau = a
                                                                     printf "%d" =<< ((programme_candidat tableau taille_x taille_y) :: IO Int)
                                                                     printf "\n" :: IO ()))


