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
     let p y =
           if y <= 2
           then let q x =
                      if x <= 2
                      then do ifM (((==) 0) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y))
                                  (printf " " :: IO ())
                                  (ifM (((==) 1) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y))
                                       (printf "O" :: IO ())
                                       (printf "X" :: IO ()))
                              printf "|" :: IO ()
                              q (x + 1)
                      else if y /= 2
                           then do printf "\n|-|-|-|\n|" :: IO ()
                                   p (y + 1)
                           else p (y + 1) in
                      q 0
           else printf "\n" :: IO () in
           p 0

eval0 g =
  do let win = 0
     let freecase = 0
     let n y t u =
           if y <= 2
           then do let col = - 1
                   let lin = - 1
                   let o x v w z =
                         if x <= 2
                         then do ba <- ifM (((==) 0) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y))
                                           (let bb = w + 1
                                                     in return bb)
                                           (return w)
                                 colv <- join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y
                                 linv <- join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return y) <*> return x
                                 let bc = if v == - 1 && colv /= 0
                                          then let bd = colv
                                                        in bd
                                          else if colv /= v
                                               then let be = - 2
                                                             in be
                                               else v
                                 if z == - 1 && linv /= 0
                                 then do let bf = linv
                                         o (x + 1) bc ba bf
                                 else if linv /= z
                                      then do let bg = - 2
                                              o (x + 1) bc ba bg
                                      else o (x + 1) bc ba z
                         else if v >= 0
                              then do let bh = v
                                      n (y + 1) w bh
                              else if z >= 0
                                   then do let bi = z
                                           n (y + 1) w bi
                                   else n (y + 1) w u in
                         o 0 col t lin
           else let l x bj =
                      if x <= 2
                      then do bk <- ifM (((((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 0) <*> return 0)) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 1) <*> return 1))) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 2) <*> return 2)))
                                        (let bl = x
                                                  in return bl)
                                        (return bj)
                              ifM (((((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 0) <*> return 2)) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 1) <*> return 1))) <&&> (((==) x) <$> (join $ readIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return 2) <*> return 0)))
                                  (do let bm = x
                                      l (x + 1) bm)
                                  (l (x + 1) bk)
                      else do writeIORef (_ended g) (bj /= 0 || t == 0)
                              if bj == 1
                              then writeIORef (_note g) 1000
                              else if bj == 2
                                   then writeIORef (_note g) (- 1000)
                                   else writeIORef (_note g) 0 in
                      l 1 u in
           n 0 freecase win

apply_move_xy x y g =
  do let player = 2
     bn <- ifM (readIORef (_firstToPlay g))
               (let bo = 1
                         in return bo)
               (return player)
     join $ writeIOA <$> (join $ readIOA <$> (readIORef (_cases g)) <*> return x) <*> return y <*> return bn
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
             bp <- ifM (fmap not (readIORef (_firstToPlay g)))
                       (let bq = 10000
                                 in return bq)
                       (return maxNote)
             let h x br =
                   if x <= 2
                   then let k y bs =
                              if y <= 2
                              then ifM (can_move_xy x y g)
                                       (do apply_move_xy x y g
                                           currentNote <- minmax g
                                           cancel_move_xy x y g
                                           {- Minimum ou Maximum selon le coté ou l'on joue-}
                                           ifM (((==) (currentNote > bs)) <$> (readIORef (_firstToPlay g)))
                                               (do let bt = currentNote
                                                   k (y + 1) bt)
                                               (k (y + 1) bs))
                                       (k (y + 1) bs)
                              else h (x + 1) bs in
                              k 0 br
                   else return br in
                   h 0 bp)

play g =
  do minMove <- (Move <$> (newIORef 0) <*> (newIORef 0))
     let minNote = 10000
     let e x bu =
           if x <= 2
           then let f y bv =
                      if y <= 2
                      then ifM (can_move_xy x y g)
                               (do apply_move_xy x y g
                                   currentNote <- minmax g
                                   printf "%d, %d, %d\n" (x::Int) (y::Int) (currentNote::Int) :: IO()
                                   cancel_move_xy x y g
                                   if currentNote < bv
                                   then do let bw = currentNote
                                           writeIORef (_x minMove) x
                                           writeIORef (_y minMove) y
                                           f (y + 1) bw
                                   else f (y + 1) bv)
                               (f (y + 1) bv)
                      else e (x + 1) bv in
                      f 0 bu
           else do join $ printf "%d%d\n" <$> ((readIORef (_x minMove))::IO Int) <*> ((readIORef (_y minMove))::IO Int)
                   return minMove in
           e 0 minNote

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
  let r i =
        if i <= 1
        then do state <- init0 ()
                join $ apply_move <$> (Move <$> (newIORef 1) <*> (newIORef 1)) <*> return state
                join $ apply_move <$> (Move <$> (newIORef 0) <*> (newIORef 0)) <*> return state
                let s () =
                      ifM (fmap not (readIORef (_ended state)))
                          (do print_state state
                              join $ apply_move <$> (play state) <*> return state
                              eval0 state
                              print_state state
                              ifM (fmap not (readIORef (_ended state)))
                                  (do join $ apply_move <$> (play state) <*> return state
                                      eval0 state
                                      s ())
                                  (s ()))
                          (do print_state state
                              printf "%d\n" =<< ((readIORef (_note state))::IO Int)
                              r (i + 1)) in
                      s ()
        else return () in
        r 0


