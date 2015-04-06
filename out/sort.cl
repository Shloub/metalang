
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

(defun copytab (tab len)
(progn
  (let
   ((o (array_init
          len
          (function (lambda (i)
          (block lambda_1
            (return-from lambda_1 (aref tab i))
          ))
          ))))
  (return-from copytab o)
  )))

(defun bubblesort (tab len)
(loop for i from 0 to (- len 1) do
  (loop for j from (+ i 1) to (- len 1) do
    (if
      (> (aref tab i) (aref tab j))
      (progn
        (let ((tmp (aref tab i)))
          (setf (aref tab i) (aref tab j))
          (setf (aref tab j) tmp)
        ))))))

(defun qsort0 (tab len i j)
(if
  (< i j)
  (progn
    (let ((i0 i))
      (let ((j0 j))
        #| pivot : tab[0] |#
        (loop while (not (= i j))
        do (if
             (> (aref tab i) (aref tab j))
             (if
               (= i (- j 1))
               (progn
                 #| on inverse simplement|#
                 (let ((tmp (aref tab i)))
                   (setf (aref tab i) (aref tab j))
                   (setf (aref tab j) tmp)
                   (setq i (+ i 1))
                 ))
               (progn
                 #| on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] |#
                 (let ((tmp (aref tab i)))
                   (setf (aref tab i) (aref tab j))
                   (setf (aref tab j) (aref tab (+ i 1)))
                   (setf (aref tab (+ i 1)) tmp)
                   (setq i (+ i 1))
                 )))
             (setq j (- j 1)))
        )
        (qsort0 tab len i0 (- i 1))
        (qsort0 tab len (+ i 1) j0)
      )))))

(progn
  (let ((len 2))
    (setq len (mread-int ))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i_)
              (block lambda_2
                (let ((tmp 0))
                  (setq tmp (mread-int ))
                  (mread-blank)
                  (return-from lambda_2 tmp)
                )))
              ))))
    (let ((tab2 (copytab tab len)))
      (bubblesort tab2 len)
      (loop for i from 0 to (- len 1) do
        (format t "~D " (aref tab2 i)))
      (princ (format nil "~C" #\NewLine))
      (let ((tab3 (copytab tab len)))
        (qsort0 tab3 len 0 (- len 1))
        (loop for i from 0 to (- len 1) do
          (format t "~D " (aref tab3 i)))
        (princ (format nil "~C" #\NewLine))
      )))))


