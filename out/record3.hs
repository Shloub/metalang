import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b


main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

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


array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     o <- newListArray (0, len - 1) li
     return (env, o)
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)



data Toto = Toto {
                    _foo :: IORef Int,
                    _bar :: IORef Int,
                    _blah :: IORef Int
                    }
  deriving Eq

mktoto v1 =
  do t <- (Toto <$> (newIORef v1) <*> (newIORef 0) <*> (newIORef 0))
     return (t)
result t len =
  do let out0 = 0
     let b = 0
     let c = (len - 1)
     let a j h =
           (if (j <= c)
           then do (join (writeIORef <$> (_blah <$> (readIOA t j)) <*> ((+) <$> (join (readIORef <$> (_blah <$> (readIOA t j)))) <*> return (1))))
                   k <- ((+) <$> ((+) <$> (((+) h) <$> (join (readIORef <$> (_foo <$> (readIOA t j))))) <*> ((*) <$> (join (readIORef <$> (_blah <$> (readIOA t j)))) <*> (join (readIORef <$> (_bar <$> (readIOA t j)))))) <*> ((*) <$> (join (readIORef <$> (_bar <$> (readIOA t j)))) <*> (join (readIORef <$> (_foo <$> (readIOA t j))))))
                   (a (j + 1) k)
           else return (h)) in
           (a b out0)
main =
  ((\ (e, t) ->
     do return (e)
        g <- read_int
        (join (writeIORef <$> (_bar <$> (readIOA t 0)) <*> (return g)))
        skip_whitespaces
        f <- read_int
        (join (writeIORef <$> (_blah <$> (readIOA t 1)) <*> (return f)))
        titi <- (result t 4)
        printf "%d" (titi :: Int)::IO()
        printf "%d" =<< ((join (readIORef <$> (_blah <$> (readIOA t 2)))) :: IO Int)) =<< (array_init_withenv 4 (\ i () ->
                                                                                                                  do d <- (mktoto i)
                                                                                                                     return (((), d))) ()))
