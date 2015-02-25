import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

main :: IO ()




main =
  do printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return 4))) :: IO Int)
     printf " " :: IO ()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return 16))) :: IO Int)
     printf " " :: IO ()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return 20))) :: IO Int)
     printf " " :: IO ()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return 1000))) :: IO Int)
     printf " " :: IO ()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return 500))) :: IO Int)
     printf " " :: IO ()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return 10))) :: IO Int)
     printf " " :: IO ()


