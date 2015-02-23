import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

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
     let l = 0
     let m = (taille_y - 1)
     let f i s =
           (if (i <= m)
           then do let h = 0
                   let k = (taille_x - 1)
                   let g j u =
                         (if (j <= k)
                         then do v <- (((+) u) <$> ((*) <$> ((fmap ord (join (readIOA <$> (readIOA tableau i) <*> return (j))))) <*> return ((i + (j * 2)))))
                                 printf "%c" =<< (join (readIOA <$> (readIOA tableau i) <*> return (j)) :: IO Char)
                                 (g (j + 1) v)
                         else do printf "--\n" ::IO()
                                 (f (i + 1) u)) in
                         (g h s)
           else return (s)) in
           (f l out0)
main =
  do taille_x <- read_int
     skip_whitespaces
     taille_y <- read_int
     skip_whitespaces
     ((\ (p, a) ->
        do return (p)
           let tableau = a
           printf "%d" =<< ((programme_candidat tableau taille_x taille_y) :: IO Int)
           printf "\n" ::IO()) =<< (array_init_withenv taille_y (\ b () ->
                                                                  ((\ (r, d) ->
                                                                     do return (r)
                                                                        skip_whitespaces
                                                                        let o = d
                                                                        return (((), o))) =<< (array_init_withenv taille_x (\ e () ->
                                                                                                                             hGetChar stdin >>= ((\ c ->
                                                                                                                                                   let q = c
                                                                                                                                                           in return (((), q))))) ()))) ()))

