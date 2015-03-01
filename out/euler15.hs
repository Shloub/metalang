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
  {- normalement on doit mettre 20 mais là on se tape un overflow -}
  do let t = 10 + 1
     tab <- array_init t (\ i ->
                            do tab2 <- array_init t (\ j ->
                                                       return 0)
                               return tab2)
     let g l =
           if l <= t - 1
           then do join $ writeIOA <$> (readIOA tab (t - 1)) <*> return l <*> return 1
                   join $ writeIOA <$> (readIOA tab l) <*> return (t - 1) <*> return 1
                   g (l + 1)
           else let e o =
                      if o <= t
                      then do let r = t - o
                              let f p =
                                    if p <= t
                                    then do let q = t - p
                                            join $ writeIOA <$> (readIOA tab r) <*> return q <*> ((+) <$> (join $ readIOA <$> (readIOA tab (r + 1)) <*> return q) <*> (join $ readIOA <$> (readIOA tab r) <*> return (q + 1)))
                                            f (p + 1)
                                    else e (o + 1) in
                                    f 2
                      else let c m =
                                 if m <= t - 1
                                 then let d k =
                                            if k <= t - 1
                                            then do printf "%d " =<< ((join $ readIOA <$> (readIOA tab m) <*> return k)::IO Int)
                                                    d (k + 1)
                                            else do printf "\n" :: IO ()
                                                    c (m + 1) in
                                            d 0
                                 else printf "%d\n" =<< ((join $ readIOA <$> (readIOA tab 0) <*> return 0)::IO Int) in
                                 c 0 in
                      e 2 in
           g 0


