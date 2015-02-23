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



programme_candidat tableau1 taille1 tableau2 taille2 =
  do let out0 = 0
     let k = 0
     let l = (taille1 - 1)
     let h i r =
           (if (i <= l)
           then do s <- (((+) r) <$> ((*) <$> ((fmap ord ((readIOA tableau1 i)))) <*> return (i)))
                   printf "%c" =<< ((readIOA tableau1 i) :: IO Char)
                   (h (i + 1) s)
           else do printf "--\n" ::IO()
                   let f = 0
                   let g = (taille2 - 1)
                   let e j u =
                         (if (j <= g)
                         then do v <- (((+) u) <$> ((*) <$> ((fmap ord ((readIOA tableau2 j)))) <*> return ((j * 100))))
                                 printf "%c" =<< ((readIOA tableau2 j) :: IO Char)
                                 (e (j + 1) v)
                         else do printf "--\n" ::IO()
                                 return (u)) in
                         (e f r)) in
           (h k out0)
main =
  do taille1 <- read_int
     skip_whitespaces
     ((\ (o, tableau1) ->
        do return (o)
           skip_whitespaces
           taille2 <- read_int
           skip_whitespaces
           ((\ (q, tableau2) ->
              do return (q)
                 skip_whitespaces
                 printf "%d" =<< ((programme_candidat tableau1 taille1 tableau2 taille2) :: IO Int)
                 printf "\n" ::IO()) =<< (array_init_withenv taille2 (\ c () ->
                                                                       hGetChar stdin >>= ((\ d ->
                                                                                             let p = d
                                                                                                     in return (((), p))))) ()))) =<< (array_init_withenv taille1 (\ a () ->
                                                                                                                                                                    hGetChar stdin >>= ((\ b ->
                                                                                                                                                                                          let m = b
                                                                                                                                                                                                  in return (((), m))))) ()))

