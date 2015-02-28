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
  do printf "%d" (((floor . sqrt . fromIntegral) 4) :: Int) :: IO ()
     printf " " :: IO ()
     printf "%d" (((floor . sqrt . fromIntegral) 16) :: Int) :: IO ()
     printf " " :: IO ()
     printf "%d" (((floor . sqrt . fromIntegral) 20) :: Int) :: IO ()
     printf " " :: IO ()
     printf "%d" (((floor . sqrt . fromIntegral) 1000) :: Int) :: IO ()
     printf " " :: IO ()
     printf "%d" (((floor . sqrt . fromIntegral) 500) :: Int) :: IO ()
     printf " " :: IO ()
     printf "%d" (((floor . sqrt . fromIntegral) 10) :: Int) :: IO ()
     printf " " :: IO ()


