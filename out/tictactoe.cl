
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
(defvar last-char 0)
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (loop while (and last-char (>= (char-code last-char) (char-code #\0)) (<= (char-code last-char) (char-code #\9))) do
        (progn
          (setq out (+ (* 10 out) (- (char-code last-char) (char-code #\0))))
          (next-char)
        )
      )
      out
    ))))
(defun mread-blank () (progn
  (loop while (or (eq last-char #\NewLine) (eq last-char #\Space) ) do (next-char))
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
  (loop for y from 0 to 2 do
    (progn
      (loop for x from 0 to 2 do
        (progn
          (if
            (= (aref (aref (gamestate-cases g) x) y) 0)
            (princ " ")
            (if
              (= (aref (aref (gamestate-cases g) x) y) 1)
              (princ "O")
              (princ "X")))
          (princ "|")
        ))
      (if
        (not (= y 2))
        (princ "
|-|-|-|
|")
        '())
    ))
  (princ "
")
))
#| On dit qui gagne (info stoquées dans g.ended et g.note ) |#
(defun eval0 (g)
(progn
  (let ((win 0))
    (let ((freecase 0))
      (loop for y from 0 to 2 do
        (progn
          (let ((col (- 0 1)))
            (let ((lin (- 0 1)))
              (loop for x from 0 to 2 do
                (progn
                  (if
                    (= (aref (aref (gamestate-cases g) x) y) 0)
                    (setq freecase (+ freecase 1))
                    '())
                  (let ((colv (aref (aref (gamestate-cases g) x) y)))
                    (let ((linv (aref (aref (gamestate-cases g) y) x)))
                      (if
                        (and (= col (- 0 1)) (not (= colv 0)))
                        (setq col colv)
                        (if
                          (not (= colv col))
                          (setq col (- 0 2))
                          '()))
                      (if
                        (and (= lin (- 0 1)) (not (= linv 0)))
                        (setq lin linv)
                        (if
                          (not (= linv lin))
                          (setq lin (- 0 2))
                          '()))
                    ))))
              (if
                (>= col 0)
                (setq win col)
                (if
                  (>= lin 0)
                  (setq win lin)
                  '()))
            ))))
      (loop for x from 1 to 2 do
        (progn
          (if
            (and (= (aref (aref (gamestate-cases g) 0) 0) x) (= (aref (aref (gamestate-cases g) 1) 1) x) 
            (= (aref (aref (gamestate-cases g) 2) 2) x))
            (setq win x)
            '())
          (if
            (and (= (aref (aref (gamestate-cases g) 0) 2) x) (= (aref (aref (gamestate-cases g) 1) 1) x) 
            (= (aref (aref (gamestate-cases g) 2) 0) x))
            (setq win x)
            '())
        ))
      (setf (gamestate-ended g) (or (not (= win 0)) (= freecase 0)))
      (if
        (= win 1)
        (setf (gamestate-note g) 1000)
        (if
          (= win 2)
          (setf (gamestate-note g) (- 0 1000))
          (setf (gamestate-note g) 0))))
      )
    
))
#| On applique un mouvement |#
(defun apply_move_xy (x y g)
(progn
  (let ((player 2))
    (if
      (gamestate-firstToPlay g)
      (setq player 1)
      '())
    (setf (aref (aref (gamestate-cases g) x) y) player)
    (setf (gamestate-firstToPlay g) (not (gamestate-firstToPlay g))))
    
))
(defun apply_move (m g)
(progn
  (apply_move_xy (move-x m) (move-y m) g)
))
(defun cancel_move_xy (x y g)
(progn
  (setf (aref (aref (gamestate-cases g) x) y) 0)
  (setf (gamestate-firstToPlay g) (not (gamestate-firstToPlay g)))
  (setf (gamestate-ended g) nil)
))
(defun cancel_move (m g)
(progn
  (cancel_move_xy (move-x m) (move-y m) g)
))
(defun can_move_xy (x y g)
(progn
  (return-from can_move_xy (= (aref (aref (gamestate-cases g) x) y) 0))
))
(defun can_move (m g)
(progn
  (return-from can_move (can_move_xy (move-x m) (move-y m) g))
))
#|
Un minimax classique, renvoie la note du plateau
|#
(defun minmax (g)
(progn
  (eval0 g)
  (if
    (gamestate-ended g)
    (return-from minmax (gamestate-note g))
    (progn
      (let ((maxNote (- 0 10000)))
        (if
          (not (gamestate-firstToPlay g))
          (setq maxNote 10000)
          '())
        (loop for x from 0 to 2 do
          (loop for y from 0 to 2 do
            (if
              (can_move_xy x y g)
              (progn
                (apply_move_xy x y g)
                (let ((currentNote (minmax g)))
                  (cancel_move_xy x y g)
                  #| Minimum ou Maximum selon le coté ou l'on joue|#
                  (if
                    (eq (> currentNote maxNote) (gamestate-firstToPlay g))
                    (setq maxNote currentNote)
                    '())
                ))
              '())))
        (return-from minmax maxNote)
      )))
))
#|
Renvoie le coup de l'IA
|#
(defun play (g)
(progn
  (let ((minMove (make-move :x 0 :y 0)))
  (let ((minNote 10000))
    (loop for x from 0 to 2 do
      (loop for y from 0 to 2 do
        (if
          (can_move_xy x y g)
          (progn
            (apply_move_xy x y g)
            (let ((currentNote (minmax g)))
              (format t "~D, ~D, ~D~%" x y currentNote)
              (cancel_move_xy x y g)
              (if
                (< currentNote minNote)
                (progn
                  (setq minNote currentNote)
                  (setf (move-x minMove) x)
                  (setf (move-y minMove) y)
                )
                '())
            ))
          '())))
    (format t "~D~D~%" (move-x minMove) (move-y minMove))
    (return-from play minMove))
    )
  
))
(defun init0 ()
(progn
  (let
   ((cases (array_init
              3
              (function (lambda (i)
              (block lambda_1
                (let
                 ((tab (array_init
                          3
                          (function (lambda (j)
                          (block lambda_2
                            (return-from lambda_2 0)
                          ))
                          ))))
                (return-from lambda_1 tab)
                )))
              ))))
  (let ((a (make-gamestate :cases cases :firstToPlay t :note 0 :ended nil)))
  (return-from init0 a))
  )
  
))
(defun read_move ()
(progn
  (let ((x (mread-int)))
    (mread-blank)
    (let ((y (mread-int)))
      (mread-blank)
      (let ((b (make-move :x x :y y)))
      (return-from read_move b))
      )
    )
  
))
(progn
  (loop for i from 0 to 1 do
    (progn
      (let ((state (init0 )))
        (let ((c (make-move :x 1 :y 1)))
        (apply_move c state)
        (let ((d (make-move :x 0 :y 0)))
        (apply_move d state)
        (loop while (not (gamestate-ended state))
        do (progn
             (print_state state)
             (apply_move (play state) state)
             (eval0 state)
             (print_state state)
             (if
               (not (gamestate-ended state))
               (progn
                 (apply_move (play state) state)
                 (eval0 state)
               )
               '())
             )
        )
        (print_state state)
        (format t "~D~%" (gamestate-note state))
      )))))
)

