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
skip_whitespaces :: IO ()
skip_whitespaces =
  ifM isEOF
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do getChar
              skip_whitespaces
           else return ())
read_int_a :: Int -> IO Int
read_int_a b =
  ifM isEOF
      (return b)
      (do c <- hLookAhead stdin
          if isNumber c then
           do getChar
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      (* sign) <$> read_int_a 0
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()


position_alphabet c =
  do i <- ((fmap ord (return c)))
     ifM ((((<=) i) <$> ((fmap ord (return 'Z')))) <&&> (((>=) i) <$> ((fmap ord (return 'A')))))
         (((-) i) <$> ((fmap ord (return 'A'))))
         (ifM ((((<=) i) <$> ((fmap ord (return 'z')))) <&&> (((>=) i) <$> ((fmap ord (return 'a')))))
              (((-) i) <$> ((fmap ord (return 'a'))))
              (return (- 1)))

of_position_alphabet c =
  ((fmap chr ((((+) c) <$> ((fmap ord (return 'a')))))))

crypte taille_cle cle taille message =
  do let b = taille - 1
     let a i =
           if i <= b
           then do lettre <- (readIOA message i) >>= position_alphabet
                   if lettre /= - 1
                   then do addon <- (readIOA cle (i `rem` taille_cle)) >>= position_alphabet
                           let new0 = (addon + lettre) `rem` 26
                           writeIOA message i =<< (of_position_alphabet new0)
                           a (i + 1)
                   else a (i + 1)
           else return () in
           a 0

main =
  do taille_cle <- read_int
     skip_whitespaces
     cle <- array_init taille_cle (\ index ->
                                    hGetChar stdin >>= ((\ out0 ->
                                                          return out0)))
     skip_whitespaces
     taille <- read_int
     skip_whitespaces
     message <- array_init taille (\ index2 ->
                                    hGetChar stdin >>= ((\ out2 ->
                                                          return out2)))
     crypte taille_cle cle taille message
     let j = taille - 1
     let h i =
           if i <= j
           then do printf "%c" =<< (readIOA message i :: IO Char)
                   h (i + 1)
           else printf "\n" :: IO () in
           h 0


