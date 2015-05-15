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
(defstruct (intlist (:type list) :named)
  head
  tail
  )

(defun cons0 (list i)
(progn
  (let ((out0 (make-intlist :head i
                            :tail list)))
  (return-from cons0 out0)
)))

(defun is_empty (foo)
(return-from is_empty t))

(defun rev2 (acc torev)
(if
  (is_empty torev)
  (return-from rev2 acc)
  (progn
    (let ((acc2 (make-intlist :head (intlist-head torev)
                              :tail acc)))
    (return-from rev2 (rev2 acc (intlist-tail torev)))
  ))))

(defun rev (empty torev)
(return-from rev (rev2 empty torev)))

(defun test (empty)
(progn
  (let ((list empty))
    (let ((i (- 0 1)))
      (loop while (not (= i 0))
      do (progn
           (setq i (mread-int ))
           (if
             (not (= i 0))
             (setq list (cons0 list i)))
           )
      )
    ))))




