import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


main :: IO ()




data Toto = Toto {
                    _foo :: IORef (Int, Int),
                    _bar :: IORef Int
                    }
  deriving Eq


main =
  do bar_ <- (fmap read getLine)
     t <- (Toto <$> (( (fmap read . head . reads) <$> getLine :: IO (Int, Int)) >>= newIORef) <*> (newIORef bar_))
     (readIORef (_foo t)) >>= (\ (a, b) ->
                                do printf "%d" (a :: Int) :: IO ()
                                   printf " " :: IO ()
                                   printf "%d" (b :: Int) :: IO ()
                                   printf " " :: IO ()
                                   printf "%d" =<< (readIORef (_bar t) :: IO Int)
                                   printf "\n" :: IO ())


