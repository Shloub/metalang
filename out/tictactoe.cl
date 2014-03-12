
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))
(defun not-equal (a b) (not (eq a b)))
(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (while (and last-char (>= (char-int last-char) (char-int #\0)) (<= (char-int last-char) (char-int #\9)))
        (progn
          (setq out (+ (* 10 out) (- (char-int last-char) (char-int #\0))))
          (next-char)
        )
      )
      out
    ))))
(defun mread-blank () (progn
  (while (or (eq last-char #\NewLine) (eq last-char #\Space) ) (next-char))
))
#|
Tictactoe : un tictactoe avec une IA
|#
#| La structure de donnée |#
(defstruct (gamestate (:type list) :named)
  cases
  firstToPlay
  note
  ended
  )

#| Un Mouvement |#
(defstruct (move (:type list) :named)
  x
  y
  )

#| On affiche l'état |#
(defun print_state (g)
(progn
  (princ "
|")
  (do
    ((y 0 (+ 1 y)))
    ((> y 2))
    (progn
      (do
        ((x 0 (+ 1 x)))
        ((> x 2))
        (progn
          (if
            (eq (aref (aref (gamestate-cases g) x) y) 0)
            (princ " ")
            (if
              (eq (aref (aref (gamestate-cases g) x) y) 1)
              (princ "O")
              (princ "X")))
          (princ "|")
        )
      )
      (if
        (not-equal y 2)
        (princ "
|-|-|-|
|"))
    )
  )
  (princ "
")
))

#| On dit qui gagne (info stoquées dans g.ended et g.note ) |#
(defun eval_ (g)
(progn
  (let ((win 0))
    (let ((freecase 0))
      (do
        ((y 0 (+ 1 y)))
        ((> y 2))
        (progn
          (let ((col (- 0 1)))
            (let ((lin (- 0 1)))
              (do
                ((x 0 (+ 1 x)))
                ((> x 2))
                (progn
                  (if
                    (eq (aref (aref (gamestate-cases g) x) y) 0)
                    (setq freecase ( + freecase 1)))
                  (let ((colv (aref (aref (gamestate-cases g) x) y)))
                    (let ((linv (aref (aref (gamestate-cases g) y) x)))
                      (if
                        (and (eq col (- 0 1)) (not-equal colv 0))
                        (setq col colv)
                        (if
                          (not-equal colv col)
                          (setq col (- 0 2))))
                      (if
                        (and (eq lin (- 0 1)) (not-equal linv 0))
                        (setq lin linv)
                        (if
                          (not-equal linv lin)
                          (setq lin (- 0 2))))
                    )))
              )
              (if
                (>= col 0)
                (setq win col)
                (if
                  (>= lin 0)
                  (setq win lin)))
            )))
      )
      (do
        ((x 1 (+ 1 x)))
        ((> x 2))
        (progn
          (if
            (and (and (eq (aref (aref (gamestate-cases g) 0) 0) x) (eq (aref (aref (gamestate-cases g) 1) 1) x)) (eq (aref (aref (gamestate-cases g) 2) 2) x))
            (setq win x))
          (if
            (and (and (eq (aref (aref (gamestate-cases g) 0) 2) x) (eq (aref (aref (gamestate-cases g) 1) 1) x)) (eq (aref (aref (gamestate-cases g) 2) 0) x))
            (setq win x))
        )
      )
      (setf (gamestate-ended g) (or (not-equal win 0) (eq freecase 0)))
      (if
        (eq win 1)
        (setf (gamestate-note g) 1000)
        (if
          (eq win 2)
          (setf (gamestate-note g) (- 0 1000))
          (setf (gamestate-note g) 0)))
    ))))

#| On applique un mouvement |#
(defun apply_move_xy (x y g)
(progn
  (let ((player 2))
    (if
      (gamestate-firstToPlay g)
      (setq player 1))
    (setf (aref (aref (gamestate-cases g) x) y) player)
    (setf (gamestate-firstToPlay g) (not (gamestate-firstToPlay g)))
  )))

(defun apply_move (m g)
(apply_move_xy (move-x m)
  (move-y m)
  g))

(defun cancel_move_xy (x y g)
(progn
  (setf (aref (aref (gamestate-cases g) x) y) 0)
  (setf (gamestate-firstToPlay g) (not (gamestate-firstToPlay g)))
  (setf (gamestate-ended g) nil)
))

(defun cancel_move (m g)
(cancel_move_xy (move-x m)
  (move-y m)
  g))

(defun can_move_xy (x y g)
(return-from can_move_xy (eq (aref (aref (gamestate-cases g) x) y) 0)))

(defun can_move (m g)
(return-from can_move (can_move_xy (move-x m) (move-y m) g)))

#|
Un minimax classique, renvoie la note du plateau
|#
(defun minmax (g)
(progn
  (eval_ g)
  (if
    (gamestate-ended g)
    (return-from minmax (gamestate-note g))
    (progn
      (let ((maxNote (- 0 10000)))
        (if
          (not (gamestate-firstToPlay g))
          (setq maxNote 10000))
        (do
          ((x 0 (+ 1 x)))
          ((> x 2))
          (do
            ((y 0 (+ 1 y)))
            ((> y 2))
            (if
              (can_move_xy x
              y
              g)
              (progn
                (apply_move_xy x
                y
                g)
                (let ((currentNote (minmax g)))
                  (cancel_move_xy x
                  y
                  g)
                  #| Minimum ou Maximum selon le coté ou l'on joue|#
                  (if
                    (eq (> currentNote maxNote) (gamestate-firstToPlay g))
                    (setq maxNote currentNote))
                )))
            )
        )
        (return-from minmax maxNote)
      )))
))

#|
Renvoie le coup de l'IA
|#
(defun play (g)
(progn
  (let ((minMove (make-move :x 0
                            :y 0)))
  (let ((minNote 10000))
    (do
      ((x 0 (+ 1 x)))
      ((> x 2))
      (do
        ((y 0 (+ 1 y)))
        ((> y 2))
        (if
          (can_move_xy x
          y
          g)
          (progn
            (apply_move_xy x
            y
            g)
            (let ((currentNote (minmax g)))
              (princ x)
              (princ ", ")
              (princ y)
              (princ ", ")
              (princ currentNote)
              (princ "
")
              (cancel_move_xy x
              y
              g)
              (if
                (< currentNote minNote)
                (progn
                  (setq minNote currentNote)
                  (setf (move-x minMove) x)
                  (setf (move-y minMove) y)
                ))
            )))
        )
    )
    (let ((a (move-x minMove)))
      (princ a)
      (let ((b (move-y minMove)))
        (princ b)
        (princ "
")
        (return-from play minMove)
      ))))))

(defun init_ ()
(progn
  (let ((d 3))
    (let
     ((cases (array_init
                d
                (function (lambda (i)
                (block lambda_1
                  (let ((c 3))
                    (let
                     ((tab (array_init
                              c
                              (function (lambda (j)
                              (block lambda_2
                                (return-from lambda_2 0)
                              ))
                              ))))
                    (return-from lambda_1 tab)
                    ))))
                ))))
    (let ((out_ (make-gamestate :cases cases
                                :firstToPlay t
                                :note 0
                                :ended nil)))
    (return-from init_ out_)
    )))))

(defun read_move ()
(progn
  (let ((x (mread-int )))
    (mread-blank)
    (let ((y (mread-int )))
      (mread-blank)
      (let ((out_ (make-move :x x
                             :y y)))
      (return-from read_move out_)
    )))))

(do
  ((i 0 (+ 1 i)))
  ((> i 1))
  (progn
    (let ((state (init_ )))
      (loop while (not (gamestate-ended state))
      do (progn
           (print_state state)
           (apply_move (play state)
           state)
           (eval_ state)
           (print_state state)
           (if
             (not (gamestate-ended state))
             (progn
               (apply_move (play state)
               state)
               (eval_ state)
             ))
           )
      )
      (print_state state)
      (let ((e (gamestate-note state)))
        (princ e)
        (princ "
")
      )))
  )

