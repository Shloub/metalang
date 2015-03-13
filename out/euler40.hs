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
  let c i s =
        if i <= e
        then do let u = s * a
                c (i + 1) u
        else return s in
        c 1 1

e t n =
  let b i w =
        if i <= 8
        then ifM (((>=) w) <$> (((*) i) <$> (readIOA t i)))
                 (do x <- (((-) w) <$> (((*) i) <$> (readIOA t i)))
                     b (i + 1) x)
                 (do nombre <- (((+) (w `quot` i)) <$> (exp0 10 (i - 1)))
                     let chiffre = i - 1 - (w `rem` i)
                     (rem <$> ((quot nombre) <$> (exp0 10 chiffre)) <*> (return 10)))
        else return (- 1) in
        b 1 n

main =
  do t <- array_init 9 (\ i ->
                          ((-) <$> (exp0 10 i) <*> (exp0 10 (i - 1))))
     let r i2 =
           if i2 <= 8
           then do printf "%d => %d\n" (i2::Int) =<< ((readIOA t i2)::IO Int)
                   r (i2 + 1)
           else let q j =
                      if j <= 80
                      then do printf "%d" =<< (e t j :: IO Int)
                              q (j + 1)
                      else do printf "\n" :: IO ()
                              let p k =
                                    if k <= 50
                                    then do printf "%d" (k :: Int) :: IO ()
                                            p (k + 1)
                                    else do printf "\n" :: IO ()
                                            let m j2 =
                                                  if j2 <= 220
                                                  then do printf "%d" =<< (e t j2 :: IO Int)
                                                          m (j2 + 1)
                                                  else do printf "\n" :: IO ()
                                                          let h k2 =
                                                                if k2 <= 110
                                                                then do printf "%d" (k2 :: Int) :: IO ()
                                                                        h (k2 + 1)
                                                                else do printf "\n" :: IO ()
                                                                        let g l y =
                                                                              if l <= 6
                                                                              then do puiss <- exp0 10 l
                                                                                      v <- e t (puiss - 1)
                                                                                      let z = y * v
                                                                                      printf "10^%d=%d v=%d\n" (l::Int) (puiss::Int) (v::Int) :: IO()
                                                                                      g (l + 1) z
                                                                              else printf "%d\n" (y::Int) :: IO() in
                                                                              g 0 1 in
                                                                h 90 in
                                                  m 169 in
                                    p 1 in
                      q 0 in
           r 1


