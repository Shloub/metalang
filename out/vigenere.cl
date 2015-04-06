
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
(defun remainder (a b) (- a (* b (truncate a b))))
(defvar last-char 0)
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))
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

(defun position_alphabet (c)
(progn
  (let ((i (char-code c)))
    (if
      (and (<= i (char-code #\Z)) (>= i (char-code #\A)))
      (return-from position_alphabet (- i (char-code #\A)))
      (if
        (and (<= i (char-code #\z)) (>= i (char-code #\a)))
        (return-from position_alphabet (- i (char-code #\a)))
        (return-from position_alphabet (- 0 1))))
  )))

(defun of_position_alphabet (c)
(return-from of_position_alphabet (code-char (+ c (char-code #\a)))))

(defun crypte (taille_cle cle taille message)
(loop for i from 0 to (- taille 1) do
  (progn
    (let ((lettre (position_alphabet (aref message i))))
      (if
        (not (= lettre (- 0 1)))
        (progn
          (let ((addon (position_alphabet (aref cle (remainder i taille_cle)))))
            (let ((new0 (remainder (+ addon lettre) 26)))
              (setf (aref message i) (of_position_alphabet new0))
            ))))
    ))))

(progn
  (let ((taille_cle (mread-int )))
    (mread-blank)
    (let
     ((cle (array_init
              taille_cle
              (function (lambda (index)
              (block lambda_1
                (let ((out0 (mread-char )))
                  (return-from lambda_1 out0)
                )))
              ))))
    (mread-blank)
    (let ((taille (mread-int )))
      (mread-blank)
      (let
       ((message (array_init
                    taille
                    (function (lambda (index2)
                    (block lambda_2
                      (let ((out2 (mread-char )))
                        (return-from lambda_2 out2)
                      )))
                    ))))
      (crypte taille_cle cle taille message)
      (loop for i from 0 to (- taille 1) do
        (princ (aref message i)))
      (princ (format nil "~C" #\NewLine))
      )))))


