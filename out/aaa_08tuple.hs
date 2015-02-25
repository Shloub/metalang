import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

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
                                                                                                                                          

data Toto = Toto {
                    _foo :: IORef (Int, Int),
                    _bar :: IORef Int
                    }
  deriving Eq


main =
  do bar_ <- read_int
     skip_whitespaces
     c <- read_int
     skip_whitespaces
     d <- read_int
     skip_whitespaces
     t <- (Toto <$> (newIORef (c, d)) <*> (newIORef bar_))
     ((readIORef (_foo t)) >>= (\ (a, b) ->
                                 do printf "%d" (a :: Int) :: IO ()
                                    printf " " :: IO ()
                                    printf "%d" (b :: Int) :: IO ()
                                    printf " " :: IO ()
                                    printf "%d" =<< ((readIORef (_bar t)) :: IO Int)
                                    printf "\n" :: IO ()))


