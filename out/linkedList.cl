
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
(defstruct (intlist (:type list) :named)
  head
  tail
  )

(defun cons_ (list i)
(progn
  (let ((out_ (make-intlist :head i
                            :tail list)))
  (return-from cons_ out_)
)))

(defun rev2 (empty acc torev)
(if
  (eq torev empty)
  (return-from rev2 acc)
  (progn
    (let ((acc2 (make-intlist :head (intlist-head torev)
                              :tail acc)))
    (return-from rev2 (rev2 empty acc (intlist-tail torev)))
  ))))

(defun rev (empty torev)
(return-from rev (rev2 empty empty torev)))

(defun test (empty)
(progn
  (let ((list empty))
    (let ((i (- 0 1)))
      (loop while (not-equal i 0)
      do (progn
           (setq i (mread-int ))
           (if
             (not-equal i 0)
             (setq list (cons_ list i)))
           )
      )
    ))))

(progn
  
)

