import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

main :: IO ()
data Foo = Foo {
                  _a :: IORef Int,
                  _b :: IORef (Maybe Int),
                  _c :: IORef (Maybe (IOArray Int Int)),
                  _d :: IORef (IOArray Int (Maybe Int)),
                  _e :: IORef (IOArray Int Int),
                  _f :: IORef (Maybe Foo),
                  _g :: IORef (IOArray Int (Maybe Foo)),
                  _h :: IORef (Maybe (IOArray Int Foo))
                  }
  deriving Eq


default0 a b c d e f =
  return 0

aa b =
  return ()

main =
  printf "___\n" :: IO ()


