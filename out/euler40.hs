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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
exp0 a e =
  let b i c =
        if i <= e
        then do let d = c * a
                b (i + 1) d
        else return c in
        b 1 1

e t n =
  let f i g =
        if i <= 8
        then ifM (((>=) g) <$> (((*) i) <$> (readIOA t i)))
                 (do h <- (((-) g) <$> (((*) i) <$> (readIOA t i)))
                     f (i + 1) h)
                 (do nombre <- (((+) (g `quot` i)) <$> (exp0 10 (i - 1)))
                     let chiffre = i - 1 - (g `rem` i)
                     (rem <$> ((quot nombre) <$> (exp0 10 chiffre)) <*> (return 10)))
        else return (- 1) in
        f 1 n

main =
  do t <- array_init 9 (\ i ->
                          ((-) <$> (exp0 10 i) <*> (exp0 10 (i - 1))))
     let m i2 =
           if i2 <= 8
           then do printf "%d => %d\n" (i2::Int) =<< ((readIOA t i2)::IO Int)
                   m (i2 + 1)
           else let p j =
                      if j <= 80
                      then do printf "%d" =<< (e t j :: IO Int)
                              p (j + 1)
                      else do printf "\n" :: IO ()
                              let q k =
                                    if k <= 50
                                    then do printf "%d" (k :: Int) :: IO ()
                                            q (k + 1)
                                    else do printf "\n" :: IO ()
                                            let r j2 =
                                                  if j2 <= 220
                                                  then do printf "%d" =<< (e t j2 :: IO Int)
                                                          r (j2 + 1)
                                                  else do printf "\n" :: IO ()
                                                          let s k2 =
                                                                if k2 <= 110
                                                                then do printf "%d" (k2 :: Int) :: IO ()
                                                                        s (k2 + 1)
                                                                else do printf "\n" :: IO ()
                                                                        let u l w =
                                                                              if l <= 6
                                                                              then do puiss <- exp0 10 l
                                                                                      v <- e t (puiss - 1)
                                                                                      let x = w * v
                                                                                      printf "10^%d=%d v=%d\n" (l::Int) (puiss::Int) (v::Int) :: IO()
                                                                                      u (l + 1) x
                                                                              else printf "%d\n" (w::Int) :: IO() in
                                                                              u 0 1 in
                                                                s 90 in
                                                  r 169 in
                                    q 1 in
                      p 0 in
           m 1


