import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
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
main =
  do let n = 10
     {- normalement on doit mettre 20 mais là on se tape un overflow -}
     do let w = n + 1
        tab <- array_init w (\ i ->
                               do tab2 <- array_init w (\ j ->
                                                          return 0)
                                  return tab2)
        let t = w - 1
        let s l =
              if l <= t
              then do join $ writeIOA <$> (readIOA tab (w - 1)) <*> return l <*> return 1
                      join $ writeIOA <$> (readIOA tab l) <*> return (w - 1) <*> return 1
                      s (l + 1)
              else let g o =
                         if o <= w
                         then do let r = w - o
                                 let h p =
                                       if p <= w
                                       then do let q = w - p
                                               join $ writeIOA <$> (readIOA tab r) <*> return q <*> ((+) <$> (join $ readIOA <$> (readIOA tab (r + 1)) <*> return q) <*> (join $ readIOA <$> (readIOA tab r) <*> return (q + 1)))
                                               h (p + 1)
                                       else g (o + 1) in
                                       h 2
                         else do let f = w - 1
                                 let c m =
                                       if m <= f
                                       then do let e = w - 1
                                               let d k =
                                                     if k <= e
                                                     then do printf "%d " =<< ((join $ readIOA <$> (readIOA tab m) <*> return k)::IO Int) :: IO()
                                                             d (k + 1)
                                                     else do printf "\n" :: IO ()
                                                             c (m + 1) in
                                                     d 0
                                       else printf "%d\n" =<< ((join $ readIOA <$> (readIOA tab 0) <*> return 0)::IO Int) :: IO() in
                                       c 0 in
                         g 2 in
              s 0


