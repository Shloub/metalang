import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

main :: IO ()
min2_ a b =
  return (if a < b
          then a
          else b)

main =
  join $ printf "%d %d %d %d %d %d\n" <$> ((join $ min2_ <$> (min2_ 2 3) <*> return 4)::IO Int) <*> ((join $ min2_ <$> (min2_ 2 4) <*> return 3)::IO Int) <*> ((join $ min2_ <$> (min2_ 3 2) <*> return 4)::IO Int) <*> ((join $ min2_ <$> (min2_ 3 4) <*> return 2)::IO Int) <*> ((join $ min2_ <$> (min2_ 4 2) <*> return 3)::IO Int) <*> ((join $ min2_ <$> (min2_ 4 3) <*> return 2)::IO Int) :: IO()


