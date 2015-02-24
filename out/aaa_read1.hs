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
                                                                                                                                          
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

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
                                                                                                                                          

main =
  ((array_init_withenv 12 (\ a d ->
                            hGetChar stdin >>= ((\ b ->
                                                  let c = b
                                                          in return ((), c)))) ()) >>= (\ (d, str) ->
                                                                                         do skip_whitespaces
                                                                                            let e i =
                                                                                                  (if (i <= 11)
                                                                                                  then do printf "%c" =<< ((readIOA str i) :: IO Char)
                                                                                                          (e (i + 1))
                                                                                                  else return ()) in
                                                                                                  (e 0)))


