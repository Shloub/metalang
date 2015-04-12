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
                let f x h k l =
                      if x <= 2
                      then do n <- ifM (((==) 0) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y))
                                       (let r = k + 1
                                                in return r)
                                       (return k)
                              colv <- join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y
                              linv <- join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return y) <*> return x
                              let o = if h == - 1 && colv /= 0
                                      then colv
                                      else if colv /= h
                                           then let q = - 2
                                                        in q
                                           else h
                              if l == - 1 && linv /= 0
                              then f (x + 1) o n linv
                              else if linv /= l
                                   then do let p = - 2
                                           f (x + 1) o n p
                                   else f (x + 1) o n l
                      else if h >= 0
                           then c (y + 1) k h
                           else if l >= 0
                                then c (y + 1) k l
                                else c (y + 1) k e in
                      f 0 col d lin
        else let s x t =
                   if x <= 2
                   then do u <- ifM (((((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 0) <*> return 0)) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 1) <*> return 1))) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 2) <*> return 2)))
                                    (return x)
                                    (return t)
                           ifM (((((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 0) <*> return 2)) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 1) <*> return 1))) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 2) <*> return 0)))
                               (s (x + 1) x)
                               (s (x + 1) u)
                   else do writeIORef (_ended g) (t /= 0 || d == 0)
                           if t == 1
                           then writeIORef (_note g) 1000
                           else if t == 2
                                then writeIORef (_note g) (- 1000)
                                else writeIORef (_note g) 0 in
                   s 1 e in
        c 0 0 0

apply_move_xy x y g =
  do v <- ifM (readIORef (_firstToPlay g))
              (return 1)
              (return 2)
     join $ writeIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y <*> return v
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
             w <- ifM (fmap not (readIORef (_firstToPlay g)))
                      (return 10000)
                      (return maxNote)
             let z x ba =
                   if x <= 2
                   then let bb y bc =
                               if y <= 2
                               then ifM (can_move_xy x y g)
                                        (do apply_move_xy x y g
                                            currentNote <- minmax g
                                            cancel_move_xy x y g
                                            {- Minimum ou Maximum selon le coté ou l'on joue-}
                                            ifM (((==) (currentNote > bc)) <$> (readIORef (_firstToPlay g)))
                                                (bb (y + 1) currentNote)
                                                (bb (y + 1) bc))
                                        (bb (y + 1) bc)
                               else z (x + 1) bc in
                               bb 0 ba
                   else return ba in
                   z 0 w)

play g =
  do minMove <- (Move <$> (newIORef 0) <*> (newIORef 0))
     let bd x be =
            if x <= 2
            then let bf y bg =
                        if y <= 2
                        then ifM (can_move_xy x y g)
                                 (do apply_move_xy x y g
                                     currentNote <- minmax g
                                     printf "%d, %d, %d\n" (x::Int) (y::Int) (currentNote::Int) :: IO()
                                     cancel_move_xy x y g
                                     if currentNote < bg
                                     then do writeIORef (_x minMove) x
                                             writeIORef (_y minMove) y
                                             bf (y + 1) currentNote
                                     else bf (y + 1) bg)
                                 (bf (y + 1) bg)
                        else bd (x + 1) bg in
                        bf 0 be
            else do join $ printf "%d%d\n" <$> ((readIORef (_x minMove))::IO Int) <*> ((readIORef (_y minMove))::IO Int)
                    return minMove in
            bd 0 10000

init0 () =
  do cases <- array_init 3 (\ i ->
                              do tab <- array_init 3 (\ j ->
                                                        return 0)
                                 return tab)
     (Gamestate <$> (newIORef cases) <*> (newIORef True) <*> (newIORef 0) <*> (newIORef False))

read_move () =
  do x <- read_int
     skip_whitespaces
     y <- read_int
     skip_whitespaces
     (Move <$> (newIORef x) <*> (newIORef y))

main =
  let bh i =
         if i <= 1
         then do state <- init0 ()
                 join $ apply_move <$> (Move <$> (newIORef 1) <*> (newIORef 1)) <*> return state
                 join $ apply_move <$> (Move <$> (newIORef 0) <*> (newIORef 0)) <*> return state
                 let bi () =
                        ifM (fmap not (readIORef (_ended state)))
                            (do print_state state
                                join $ apply_move <$> (play state) <*> return state
                                eval0 state
                                print_state state
                                ifM (fmap not (readIORef (_ended state)))
                                    (do join $ apply_move <$> (play state) <*> return state
                                        eval0 state
                                        bi ())
                                    (bi ()))
                            (do print_state state
                                printf "%d\n" =<< ((readIORef (_note state))::IO Int)
                                bh (i + 1)) in
                        bi ()
         else return () in
         bh 0


