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
skip_whitespaces :: IO ()
skip_whitespaces =
  ifM isEOF
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do getChar
              skip_whitespaces
           else return ())
read_int_a :: Int -> IO Int
read_int_a b =
  ifM isEOF
      (return b)
      (do c <- hLookAhead stdin
          if isNumber c then
           do getChar
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      (* sign) <$> read_int_a 0
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
read_sudoku () =
  array_init (9 * 9) (\ i ->
                        do k <- read_int
                           skip_whitespaces
                           return k)

print_sudoku sudoku0 =
  let a y =
        if y <= 8
        then let b x =
                   if x <= 8
                   then do printf "%d " =<< ((readIOA sudoku0 (x + y * 9))::IO Int)
                           if (x `rem` 3) == 2
                           then do printf " " :: IO ()
                                   b (x + 1)
                           else b (x + 1)
                   else do printf "\n" :: IO ()
                           if (y `rem` 3) == 2
                           then do printf "\n" :: IO ()
                                   a (y + 1)
                           else a (y + 1) in
                   b 0
        else printf "\n" :: IO () in
        a 0

sudoku_done s =
  let c i =
        if i <= 80
        then ifM (((==) 0) <$> (readIOA s i))
                 (return False)
                 (c (i + 1))
        else return True in
        c 0

sudoku_error s =
  let d x e =
        if x <= 8
        then do q <- (((((((((((((((((((((((((((((((((((((return e) <||> ((((/=) 0) <$> (readIOA s x)) <&&> ((==) <$> (readIOA s x) <*> (readIOA s (x + 9))))) <||> ((((/=) 0) <$> (readIOA s x)) <&&> ((==) <$> (readIOA s x) <*> (readIOA s (x + 9 * 2))))) <||> ((((/=) 0) <$> (readIOA s (x + 9))) <&&> ((==) <$> (readIOA s (x + 9)) <*> (readIOA s (x + 9 * 2))))) <||> ((((/=) 0) <$> (readIOA s x)) <&&> ((==) <$> (readIOA s x) <*> (readIOA s (x + 9 * 3))))) <||> ((((/=) 0) <$> (readIOA s (x + 9))) <&&> ((==) <$> (readIOA s (x + 9)) <*> (readIOA s (x + 9 * 3))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 2))) <&&> ((==) <$> (readIOA s (x + 9 * 2)) <*> (readIOA s (x + 9 * 3))))) <||> ((((/=) 0) <$> (readIOA s x)) <&&> ((==) <$> (readIOA s x) <*> (readIOA s (x + 9 * 4))))) <||> ((((/=) 0) <$> (readIOA s (x + 9))) <&&> ((==) <$> (readIOA s (x + 9)) <*> (readIOA s (x + 9 * 4))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 2))) <&&> ((==) <$> (readIOA s (x + 9 * 2)) <*> (readIOA s (x + 9 * 4))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 3))) <&&> ((==) <$> (readIOA s (x + 9 * 3)) <*> (readIOA s (x + 9 * 4))))) <||> ((((/=) 0) <$> (readIOA s x)) <&&> ((==) <$> (readIOA s x) <*> (readIOA s (x + 9 * 5))))) <||> ((((/=) 0) <$> (readIOA s (x + 9))) <&&> ((==) <$> (readIOA s (x + 9)) <*> (readIOA s (x + 9 * 5))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 2))) <&&> ((==) <$> (readIOA s (x + 9 * 2)) <*> (readIOA s (x + 9 * 5))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 3))) <&&> ((==) <$> (readIOA s (x + 9 * 3)) <*> (readIOA s (x + 9 * 5))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 4))) <&&> ((==) <$> (readIOA s (x + 9 * 4)) <*> (readIOA s (x + 9 * 5))))) <||> ((((/=) 0) <$> (readIOA s x)) <&&> ((==) <$> (readIOA s x) <*> (readIOA s (x + 9 * 6))))) <||> ((((/=) 0) <$> (readIOA s (x + 9))) <&&> ((==) <$> (readIOA s (x + 9)) <*> (readIOA s (x + 9 * 6))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 2))) <&&> ((==) <$> (readIOA s (x + 9 * 2)) <*> (readIOA s (x + 9 * 6))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 3))) <&&> ((==) <$> (readIOA s (x + 9 * 3)) <*> (readIOA s (x + 9 * 6))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 4))) <&&> ((==) <$> (readIOA s (x + 9 * 4)) <*> (readIOA s (x + 9 * 6))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 5))) <&&> ((==) <$> (readIOA s (x + 9 * 5)) <*> (readIOA s (x + 9 * 6))))) <||> ((((/=) 0) <$> (readIOA s x)) <&&> ((==) <$> (readIOA s x) <*> (readIOA s (x + 9 * 7))))) <||> ((((/=) 0) <$> (readIOA s (x + 9))) <&&> ((==) <$> (readIOA s (x + 9)) <*> (readIOA s (x + 9 * 7))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 2))) <&&> ((==) <$> (readIOA s (x + 9 * 2)) <*> (readIOA s (x + 9 * 7))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 3))) <&&> ((==) <$> (readIOA s (x + 9 * 3)) <*> (readIOA s (x + 9 * 7))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 4))) <&&> ((==) <$> (readIOA s (x + 9 * 4)) <*> (readIOA s (x + 9 * 7))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 5))) <&&> ((==) <$> (readIOA s (x + 9 * 5)) <*> (readIOA s (x + 9 * 7))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 6))) <&&> ((==) <$> (readIOA s (x + 9 * 6)) <*> (readIOA s (x + 9 * 7))))) <||> ((((/=) 0) <$> (readIOA s x)) <&&> ((==) <$> (readIOA s x) <*> (readIOA s (x + 9 * 8))))) <||> ((((/=) 0) <$> (readIOA s (x + 9))) <&&> ((==) <$> (readIOA s (x + 9)) <*> (readIOA s (x + 9 * 8))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 2))) <&&> ((==) <$> (readIOA s (x + 9 * 2)) <*> (readIOA s (x + 9 * 8))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 3))) <&&> ((==) <$> (readIOA s (x + 9 * 3)) <*> (readIOA s (x + 9 * 8))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 4))) <&&> ((==) <$> (readIOA s (x + 9 * 4)) <*> (readIOA s (x + 9 * 8))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 5))) <&&> ((==) <$> (readIOA s (x + 9 * 5)) <*> (readIOA s (x + 9 * 8))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 6))) <&&> ((==) <$> (readIOA s (x + 9 * 6)) <*> (readIOA s (x + 9 * 8))))) <||> ((((/=) 0) <$> (readIOA s (x + 9 * 7))) <&&> ((==) <$> (readIOA s (x + 9 * 7)) <*> (readIOA s (x + 9 * 8)))))
                d (x + 1) q
        else let f g h =
                   if g <= 8
                   then do o <- (((((((((((((((((((((((((((((((((((((return h) <||> ((((/=) 0) <$> (readIOA s (g * 9))) <&&> ((==) <$> (readIOA s (g * 9)) <*> (readIOA s (g * 9 + 1))))) <||> ((((/=) 0) <$> (readIOA s (g * 9))) <&&> ((==) <$> (readIOA s (g * 9)) <*> (readIOA s (g * 9 + 2))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 1))) <&&> ((==) <$> (readIOA s (g * 9 + 1)) <*> (readIOA s (g * 9 + 2))))) <||> ((((/=) 0) <$> (readIOA s (g * 9))) <&&> ((==) <$> (readIOA s (g * 9)) <*> (readIOA s (g * 9 + 3))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 1))) <&&> ((==) <$> (readIOA s (g * 9 + 1)) <*> (readIOA s (g * 9 + 3))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 2))) <&&> ((==) <$> (readIOA s (g * 9 + 2)) <*> (readIOA s (g * 9 + 3))))) <||> ((((/=) 0) <$> (readIOA s (g * 9))) <&&> ((==) <$> (readIOA s (g * 9)) <*> (readIOA s (g * 9 + 4))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 1))) <&&> ((==) <$> (readIOA s (g * 9 + 1)) <*> (readIOA s (g * 9 + 4))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 2))) <&&> ((==) <$> (readIOA s (g * 9 + 2)) <*> (readIOA s (g * 9 + 4))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 3))) <&&> ((==) <$> (readIOA s (g * 9 + 3)) <*> (readIOA s (g * 9 + 4))))) <||> ((((/=) 0) <$> (readIOA s (g * 9))) <&&> ((==) <$> (readIOA s (g * 9)) <*> (readIOA s (g * 9 + 5))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 1))) <&&> ((==) <$> (readIOA s (g * 9 + 1)) <*> (readIOA s (g * 9 + 5))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 2))) <&&> ((==) <$> (readIOA s (g * 9 + 2)) <*> (readIOA s (g * 9 + 5))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 3))) <&&> ((==) <$> (readIOA s (g * 9 + 3)) <*> (readIOA s (g * 9 + 5))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 4))) <&&> ((==) <$> (readIOA s (g * 9 + 4)) <*> (readIOA s (g * 9 + 5))))) <||> ((((/=) 0) <$> (readIOA s (g * 9))) <&&> ((==) <$> (readIOA s (g * 9)) <*> (readIOA s (g * 9 + 6))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 1))) <&&> ((==) <$> (readIOA s (g * 9 + 1)) <*> (readIOA s (g * 9 + 6))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 2))) <&&> ((==) <$> (readIOA s (g * 9 + 2)) <*> (readIOA s (g * 9 + 6))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 3))) <&&> ((==) <$> (readIOA s (g * 9 + 3)) <*> (readIOA s (g * 9 + 6))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 4))) <&&> ((==) <$> (readIOA s (g * 9 + 4)) <*> (readIOA s (g * 9 + 6))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 5))) <&&> ((==) <$> (readIOA s (g * 9 + 5)) <*> (readIOA s (g * 9 + 6))))) <||> ((((/=) 0) <$> (readIOA s (g * 9))) <&&> ((==) <$> (readIOA s (g * 9)) <*> (readIOA s (g * 9 + 7))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 1))) <&&> ((==) <$> (readIOA s (g * 9 + 1)) <*> (readIOA s (g * 9 + 7))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 2))) <&&> ((==) <$> (readIOA s (g * 9 + 2)) <*> (readIOA s (g * 9 + 7))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 3))) <&&> ((==) <$> (readIOA s (g * 9 + 3)) <*> (readIOA s (g * 9 + 7))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 4))) <&&> ((==) <$> (readIOA s (g * 9 + 4)) <*> (readIOA s (g * 9 + 7))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 5))) <&&> ((==) <$> (readIOA s (g * 9 + 5)) <*> (readIOA s (g * 9 + 7))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 6))) <&&> ((==) <$> (readIOA s (g * 9 + 6)) <*> (readIOA s (g * 9 + 7))))) <||> ((((/=) 0) <$> (readIOA s (g * 9))) <&&> ((==) <$> (readIOA s (g * 9)) <*> (readIOA s (g * 9 + 8))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 1))) <&&> ((==) <$> (readIOA s (g * 9 + 1)) <*> (readIOA s (g * 9 + 8))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 2))) <&&> ((==) <$> (readIOA s (g * 9 + 2)) <*> (readIOA s (g * 9 + 8))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 3))) <&&> ((==) <$> (readIOA s (g * 9 + 3)) <*> (readIOA s (g * 9 + 8))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 4))) <&&> ((==) <$> (readIOA s (g * 9 + 4)) <*> (readIOA s (g * 9 + 8))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 5))) <&&> ((==) <$> (readIOA s (g * 9 + 5)) <*> (readIOA s (g * 9 + 8))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 6))) <&&> ((==) <$> (readIOA s (g * 9 + 6)) <*> (readIOA s (g * 9 + 8))))) <||> ((((/=) 0) <$> (readIOA s (g * 9 + 7))) <&&> ((==) <$> (readIOA s (g * 9 + 7)) <*> (readIOA s (g * 9 + 8)))))
                           f (g + 1) o
                   else let j l m =
                              if l <= 8
                              then do n <- (((((((((((((((((((((((((((((((((((((return m) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3)) <*> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3)) <*> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s ((l `rem` 3) * 3 * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 1) * 9 + (l `quot` 3) * 3 + 2)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 2))))) <||> ((((/=) 0) <$> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1))) <&&> ((==) <$> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 1)) <*> (readIOA s (((l `rem` 3) * 3 + 2) * 9 + (l `quot` 3) * 3 + 2)))))
                                      j (l + 1) n
                              else return ((e || h) || m) in
                              j 0 False in
                   f 0 False in
        d 0 False

solve sudoku0 =
  ifM (sudoku_error sudoku0)
      (return False)
      (ifM (sudoku_done sudoku0)
           (return True)
           (let r i =
                  if i <= 80
                  then ifM (((==) 0) <$> (readIOA sudoku0 i))
                           (let t p =
                                  if p <= 9
                                  then do writeIOA sudoku0 i p
                                          ifM (solve sudoku0)
                                              (return True)
                                              (t (p + 1))
                                  else do writeIOA sudoku0 i 0
                                          return False in
                                  t 1)
                           (r (i + 1))
                  else return False in
                  r 0))

main =
  do sudoku0 <- read_sudoku ()
     print_sudoku sudoku0
     ifM (solve sudoku0)
         (do print_sudoku sudoku0
             return ())
         (printf "no solution\n" :: IO ())


