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
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
fact n =
  let a i b =
        if i <= n
        then do let c = b * i
                a (i + 1) c
        else return b in
        a 2 1

show0 lim nth =
  do t <- array_init lim (\ i ->
                            return i)
     pris <- array_init lim (\ j ->
                               return False)
     let d k e =
           if k <= lim - 1
           then do n <- fact (lim - k)
                   let nchiffre = e `quot` n
                   let g = e `rem` n
                   let h l o =
                         if l <= lim - 1
                         then ifM (fmap not (readIOA pris l))
                                  (do if o == 0
                                      then do printf "%d" (l :: Int) :: IO ()
                                              writeIOA pris l True
                                      else return ()
                                      let p = o - 1
                                      h (l + 1) p)
                                  (h (l + 1) o)
                         else d (k + 1) g in
                         h 0 nchiffre
           else let f m =
                      if m <= lim - 1
                      then ifM (fmap not (readIOA pris m))
                               (do printf "%d" (m :: Int) :: IO ()
                                   f (m + 1))
                               (f (m + 1))
                      else printf "\n" :: IO () in
                      f 0 in
           d 1 nth

main =
  do show0 10 999999
     return ()


