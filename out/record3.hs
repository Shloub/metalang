import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False
(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b
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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray


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
     return t

result t len =
  do let out0 = 0
     let b = len - 1
     let a j g =
           if j <= b
           then do (join $ writeIORef <$> (_blah <$> (readIOA t j)) <*> (((+) 1) <$> ((_blah <$> (readIOA t j)) >>= readIORef)))
                   h <- ((+) <$> ((+) <$> (((+) g) <$> ((_foo <$> (readIOA t j)) >>= readIORef)) <*> ((*) <$> ((_blah <$> (readIOA t j)) >>= readIORef) <*> ((_bar <$> (readIOA t j)) >>= readIORef))) <*> ((*) <$> ((_bar <$> (readIOA t j)) >>= readIORef) <*> ((_foo <$> (readIOA t j)) >>= readIORef)))
                   (a (j + 1) h)
           else return g in
           (a 0 out0)

main =
  ((array_init_withenv 4 (\ i d ->
                           do c <- (mktoto i)
                              return ((), c)) ()) >>= (\ (d, t) ->
                                                        do f <- read_int
                                                           (join $ writeIORef <$> (_bar <$> (readIOA t 0)) <*> return f)
                                                           skip_whitespaces
                                                           e <- read_int
                                                           (join $ writeIORef <$> (_blah <$> (readIOA t 1)) <*> return e)
                                                           titi <- (result t 4)
                                                           printf "%d" (titi :: Int) :: IO ()
                                                           printf "%d" =<< (((_blah <$> (readIOA t 2)) >>= readIORef) :: IO Int)))


