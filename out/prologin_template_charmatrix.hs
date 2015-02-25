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


skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())
                                                                                                                                                                                                                                                                         
read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)
                                                                                                                                                                                                                                                                         
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
                                                                                                                                                                                                                                                                         


programme_candidat tableau taille_x taille_y =
  do let out0 = 0
     let k = taille_y - 1
     let f i q =
           if i <= k
           then do let h = taille_x - 1
                   let g j r =
                         if j <= h
                         then do s <- (((+) r) <$> (((*) (i + j * 2)) <$> ((fmap ord ((join $ readIOA <$> (readIOA tableau i) <*> return j))))))
                                 printf "%c" =<< ((join $ readIOA <$> (readIOA tableau i) <*> return j) :: IO Char)
                                 (g (j + 1) s)
                         else do printf "--\n" :: IO ()
                                 (f (i + 1) r) in
                         (g 0 q)
           else return q in
           (f 0 out0)

main =
  do taille_x <- read_int
     skip_whitespaces
     taille_y <- read_int
     skip_whitespaces
     ((array_init_withenv taille_y (\ b m ->
                                     ((array_init_withenv taille_x (\ e p ->
                                                                     hGetChar stdin >>= ((\ c ->
                                                                                           let o = c
                                                                                                   in return ((), o)))) ()) >>= (\ (p, d) ->
                                                                                                                                  do skip_whitespaces
                                                                                                                                     let l = d
                                                                                                                                     return ((), l)))) ()) >>= (\ (m, a) ->
                                                                                                                                                                 do let tableau = a
                                                                                                                                                                    printf "%d" =<< ((programme_candidat tableau taille_x taille_y) :: IO Int)
                                                                                                                                                                    printf "\n" :: IO ()))


