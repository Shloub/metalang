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
                                                                                                                                                                                                                                                                        



position_alphabet c =
  do i <- ((fmap ord (return (c))))
     ifM (((((<=) i) <$> ((fmap ord (return ('Z'))))) <&&> (((>=) i) <$> ((fmap ord (return ('A')))))))
         ((((-) i) <$> ((fmap ord (return ('A'))))))
         (ifM (((((<=) i) <$> ((fmap ord (return ('z'))))) <&&> (((>=) i) <$> ((fmap ord (return ('a')))))))
              ((((-) i) <$> ((fmap ord (return ('a'))))))
              (return ((- 1))))

of_position_alphabet c =
  ((fmap chr ((((+) c) <$> ((fmap ord (return ('a'))))))))

crypte taille_cle cle taille message =
  do let b = (taille - 1)
     let a i =
           (if (i <= b)
           then do lettre <- (position_alphabet =<< (readIOA message i))
                   (if (lettre /= (- 1))
                   then do addon <- (position_alphabet =<< (readIOA cle (i `rem` taille_cle)))
                           let new0 = ((addon + lettre) `rem` 26)
                           writeIOA message i =<< (of_position_alphabet new0)
                           (a (i + 1))
                   else (a (i + 1)))
           else return (())) in
           (a 0)

main =
  do taille_cle <- read_int
     skip_whitespaces
     ((\ (e, cle) ->
        do skip_whitespaces
           taille <- read_int
           skip_whitespaces
           ((\ (g, message) ->
              do (crypte taille_cle cle taille message)
                 let j = (taille - 1)
                 let h i =
                       (if (i <= j)
                       then do printf "%c" =<< ((readIOA message i) :: IO Char)
                               (h (i + 1))
                       else printf "\n" ::IO()) in
                       (h 0)) =<< (array_init_withenv taille (\ index2 g ->
                                                               hGetChar stdin >>= ((\ out2 ->
                                                                                     let f = out2
                                                                                             in return (((), f))))) ()))) =<< (array_init_withenv taille_cle (\ index e ->
                                                                                                                                                               hGetChar stdin >>= ((\ out0 ->
                                                                                                                                                                                     let d = out0
                                                                                                                                                                                             in return (((), d))))) ()))


