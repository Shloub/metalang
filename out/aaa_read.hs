import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef
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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()


main =
  do len <- read_int
     skip_whitespaces
     printf "%d=len\n" (len::Int) :: IO()
     let k = len * 2
     printf "len*2=%d\n" (k::Int) :: IO()
     let l = k `quot` 2
     tab <- array_init l (\ i ->
                            do tmpi1 <- read_int
                               skip_whitespaces
                               printf "%d=>%d " (i::Int) (tmpi1::Int) :: IO()
                               return tmpi1)
     printf "\n" :: IO ()
     tab2 <- array_init l (\ i_ ->
                             do tmpi2 <- read_int
                                skip_whitespaces
                                printf "%d==>%d " (i_::Int) (tmpi2::Int) :: IO()
                                return tmpi2)
     strlen <- read_int
     skip_whitespaces
     printf "%d=strlen\n" (strlen::Int) :: IO()
     tab4 <- array_init strlen (\ toto ->
                                  do tmpc <- getChar
                                     let c = (ord tmpc)
                                     printf "%c:%d " (tmpc::Char) (c::Int) :: IO()
                                     let m = if tmpc /= ' '
                                             then let n = ((c - (ord 'a') + 13) `rem` 26) + (ord 'a')
                                                          in n
                                             else c
                                     return (chr m))
     let h j =
           if j <= strlen - 1
           then do printf "%c" =<< (readIOA tab4 j :: IO Char)
                   h (j + 1)
           else return () in
           h 0


