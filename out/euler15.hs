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
  do let a = 10 + 1
     tab <- array_init a (\ i ->
                            array_init a (\ j ->
                                            return 0))
     let b l =
           if l <= a - 1
           then do join $ writeIOA <$> (readIOA tab (a - 1)) <*> return l <*> return 1
                   join $ writeIOA <$> (readIOA tab l) <*> return (a - 1) <*> return 1
                   b (l + 1)
           else let c o =
                      if o <= a
                      then do let r = a - o
                              let f p =
                                    if p <= a
                                    then do let q = a - p
                                            join $ writeIOA <$> (readIOA tab r) <*> return q <*> ((+) <$> (join $ readIOA <$> (readIOA tab (r + 1)) <*> return q) <*> (join $ readIOA <$> (readIOA tab r) <*> return (q + 1)))
                                            f (p + 1)
                                    else c (o + 1) in
                                    f 2
                      else let d m =
                                 if m <= a - 1
                                 then let e k =
                                            if k <= a - 1
                                            then do printf "%d " =<< ((join $ readIOA <$> (readIOA tab m) <*> return k)::IO Int)
                                                    e (k + 1)
                                            else do printf "\n" :: IO ()
                                                    d (m + 1) in
                                            e 0
                                 else printf "%d\n" =<< ((join $ readIOA <$> (readIOA tab 0) <*> return 0)::IO Int) in
                                 d 0 in
                      c 2 in
           b 0


