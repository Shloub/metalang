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
data Gamestate = Gamestate {
                              _cases :: IORef (IOArray Int (IOArray Int Int)),
                              _firstToPlay :: IORef Bool,
                              _note :: IORef Int,
                              _ended :: IORef Bool
                              }
  deriving Eq


data Move = Move {
                    _x :: IORef Int,
                    _y :: IORef Int
                    }
  deriving Eq


print_state g =
  do printf "\n|" :: IO ()
     let a y =
           if y <= 2
           then let b x =
                      if x <= 2
                      then do ifM (((==) 0) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y))
                                  (printf " " :: IO ())
                                  (ifM (((==) 1) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y))
                                       (printf "O" :: IO ())
                                       (printf "X" :: IO ()))
                              printf "|" :: IO ()
                              b (x + 1)
                      else if y /= 2
                           then do printf "\n|-|-|-|\n|" :: IO ()
                                   a (y + 1)
                           else a (y + 1) in
                      b 0
           else printf "\n" :: IO () in
           a 0

eval0 g =
  let c y d e =
        if y <= 2
        then do let col = - 1
                let lin = - 1
                let l x n o p =
                      if x <= 2
                      then do q <- ifM (((==) 0) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y))
                                       (return (o + 1))
                                       (return o)
                              colv <- join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y
                              linv <- join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return y) <*> return x
                              let r = if n == - 1 && colv /= 0
                                      then colv
                                      else if colv /= n
                                           then - 2
                                           else n
                              if p == - 1 && linv /= 0
                              then l (x + 1) r q linv
                              else if linv /= p
                                   then do let s = - 2
                                           l (x + 1) r q s
                                   else l (x + 1) r q p
                      else if n >= 0
                           then c (y + 1) o n
                           else if p >= 0
                                then c (y + 1) o p
                                else c (y + 1) o e in
                      l 0 col d lin
        else let f x h =
                   if x <= 2
                   then do k <- ifM (((((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 0) <*> return 0)) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 1) <*> return 1))) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 2) <*> return 2)))
                                    (return x)
                                    (return h)
                           ifM (((((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 0) <*> return 2)) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 1) <*> return 1))) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 2) <*> return 0)))
                               (f (x + 1) x)
                               (f (x + 1) k)
                   else do writeIORef (_ended g) (h /= 0 || d == 0)
                           if h == 1
                           then writeIORef (_note g) 1000
                           else if h == 2
                                then writeIORef (_note g) (- 1000)
                                else writeIORef (_note g) 0 in
                   f 1 e in
        c 0 0 0

apply_move_xy x y g =
  do t <- ifM (readIORef (_firstToPlay g))
              (return 1)
              (return 2)
     join $ writeIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y <*> return t
     writeIORef (_firstToPlay g) =<< (fmap not (readIORef (_firstToPlay g)))

apply_move m g =
  do join $ apply_move_xy <$> (readIORef (_x m)) <*> (readIORef (_y m)) <*> return g
     return ()

cancel_move_xy x y g =
  do join $ writeIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y <*> return 0
     writeIORef (_firstToPlay g) =<< (fmap not (readIORef (_firstToPlay g)))
     writeIORef (_ended g) False

cancel_move m g =
  do join $ cancel_move_xy <$> (readIORef (_x m)) <*> (readIORef (_y m)) <*> return g
     return ()

can_move_xy x y g =
  (((==) 0) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y))

can_move m g =
  join $ can_move_xy <$> (readIORef (_x m)) <*> (readIORef (_y m)) <*> return g

minmax g =
  do eval0 g
     ifM (readIORef (_ended g))
         (readIORef (_note g))
         (do let maxNote = - 10000
             u <- ifM (fmap not (readIORef (_firstToPlay g)))
                      (return 10000)
                      (return maxNote)
             let v x w =
                   if x <= 2
                   then let z y ba =
                              if y <= 2
                              then ifM (can_move_xy x y g)
                                       (do apply_move_xy x y g
                                           currentNote <- minmax g
                                           cancel_move_xy x y g
                                           {- Minimum ou Maximum selon le coté ou l'on joue-}
                                           ifM (((==) (currentNote > ba)) <$> (readIORef (_firstToPlay g)))
                                               (z (y + 1) currentNote)
                                               (z (y + 1) ba))
                                       (z (y + 1) ba)
                              else v (x + 1) ba in
                              z 0 w
                   else return w in
                   v 0 u)

play g =
  do minMove <- (Move <$> (newIORef 0) <*> (newIORef 0))
     let bb x bc =
            if x <= 2
            then let bd y be =
                        if y <= 2
                        then ifM (can_move_xy x y g)
                                 (do apply_move_xy x y g
                                     currentNote <- minmax g
                                     printf "%d, %d, %d\n" (x::Int) (y::Int) (currentNote::Int) :: IO()
                                     cancel_move_xy x y g
                                     if currentNote < be
                                     then do writeIORef (_x minMove) x
                                             writeIORef (_y minMove) y
                                             bd (y + 1) currentNote
                                     else bd (y + 1) be)
                                 (bd (y + 1) be)
                        else bb (x + 1) be in
                        bd 0 bc
            else do join $ printf "%d%d\n" <$> ((readIORef (_x minMove))::IO Int) <*> ((readIORef (_y minMove))::IO Int)
                    return minMove in
            bb 0 10000

init0 () =
  do cases <- array_init 3 (\ i ->
                              array_init 3 (\ j ->
                                              return 0))
     (Gamestate <$> (newIORef cases) <*> (newIORef True) <*> (newIORef 0) <*> (newIORef False))

read_move () =
  do x <- read_int
     skip_whitespaces
     y <- read_int
     skip_whitespaces
     (Move <$> (newIORef x) <*> (newIORef y))

main =
  let bf i =
         if i <= 1
         then do state <- init0 ()
                 join $ apply_move <$> (Move <$> (newIORef 1) <*> (newIORef 1)) <*> return state
                 join $ apply_move <$> (Move <$> (newIORef 0) <*> (newIORef 0)) <*> return state
                 let bg () =
                        ifM (fmap not (readIORef (_ended state)))
                            (do print_state state
                                join $ apply_move <$> (play state) <*> return state
                                eval0 state
                                print_state state
                                ifM (fmap not (readIORef (_ended state)))
                                    (do join $ apply_move <$> (play state) <*> return state
                                        eval0 state
                                        bg ())
                                    (bg ()))
                            (do print_state state
                                printf "%d\n" =<< ((readIORef (_note state))::IO Int)
                                bf (i + 1)) in
                        bg ()
         else return () in
         bf 0


