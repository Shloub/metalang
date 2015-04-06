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

main :: IO ()
data Intlist = Intlist {
                          _head0 :: IORef Int,
                          _tail0 :: IORef Intlist
                          }
  deriving Eq


cons list i =
  do out0 <- (Intlist <$> (newIORef i) <*> (newIORef list))
     return out0

rev2 empty acc torev =
  if torev == empty
  then return acc
  else do acc2 <- (Intlist <$> ((readIORef (_head0 torev)) >>= newIORef) <*> (newIORef acc))
          rev2 empty acc =<< (readIORef (_tail0 torev))

rev empty torev =
  rev2 empty empty torev

test empty =
  do let i = - 1
     let a b c =
           if b /= 0
           then do d <- read_int
                   if d /= 0
                   then do e <- cons c d
                           a d e
                   else a d c
           else return () in
           a i empty

main =
  return ()


