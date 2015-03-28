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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
data Toto = Toto {
                    _s :: IORef String,
                    _v :: IORef Int
                    }
  deriving Eq


idstring s =
  return s

printstring s =
  printf "%s\n" =<< ((idstring s)::IO String)

print_toto t =
  join $ printf "%s = %d\n" <$> ((readIORef (_s t))::IO String) <*> ((readIORef (_v t))::IO Int)

main =
  do tab <- array_init 2 (\ i ->
                            idstring "chaine de test")
     let c j =
           if j <= 1
           then do ((readIOA tab j) >>= idstring) >>= printstring
                   c (j + 1)
           else do (Toto <$> (newIORef "one") <*> (newIORef 1)) >>= print_toto
                   return () in
           c 0


