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
                                                                                                                                                                                                                                                                         


programme_candidat tableau1 taille1 tableau2 taille2 =
  do let out0 = 0
     let h = (taille1 - 1)
     let g i p =
           (if (i <= h)
           then do q <- (((+) p) <$> (((*) i) <$> ((fmap ord ((readIOA tableau1 i))))))
                   printf "%c" =<< ((readIOA tableau1 i) :: IO Char)
                   (g (i + 1) q)
           else do printf "--\n" ::IO()
                   let f = (taille2 - 1)
                   let e j r =
                         (if (j <= f)
                         then do s <- (((+) r) <$> (((*) (j * 100)) <$> ((fmap ord ((readIOA tableau2 j))))))
                                 printf "%c" =<< ((readIOA tableau2 j) :: IO Char)
                                 (e (j + 1) s)
                         else do printf "--\n" ::IO()
                                 return r) in
                         (e 0 p)) in
           (g 0 out0)

main =
  do taille1 <- read_int
     skip_whitespaces
     ((array_init_withenv taille1 (\ a l ->
                                    hGetChar stdin >>= ((\ b ->
                                                          let k = b
                                                                  in return ((), k)))) ()) >>= (\ (l, tableau1) ->
                                                                                                 do skip_whitespaces
                                                                                                    taille2 <- read_int
                                                                                                    skip_whitespaces
                                                                                                    ((array_init_withenv taille2 (\ c o ->
                                                                                                                                   hGetChar stdin >>= ((\ d ->
                                                                                                                                                         let m = d
                                                                                                                                                                 in return ((), m)))) ()) >>= (\ (o, tableau2) ->
                                                                                                                                                                                                do skip_whitespaces
                                                                                                                                                                                                   printf "%d" =<< ((programme_candidat tableau1 taille1 tableau2 taille2) :: IO Int)
                                                                                                                                                                                                   printf "\n" ::IO()))))


