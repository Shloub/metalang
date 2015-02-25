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
  do let i = 4
     {-while i < 10 do -}
     do printf "%d" (i :: Int) :: IO ()
        let a = i + 1
        {-  end -}
        printf "%d" (a :: Int) :: IO ()


