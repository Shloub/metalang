(defun testA (a b)
(progn
  (if
    a
    (if
      b
      (princ "A")
      (princ "B"))
    (if
      b
      (princ "C")
      (princ "D")))
))

(defun testB (a b)
(progn
  (if
    a
    (princ "A")
    (if
      b
      (princ "B")
      (princ "C")))
))

(defun testC (a b)
(progn
  (if
    a
    (if
      b
      (princ "A")
      (princ "B"))
    (princ "C"))
))

(defun testD (a b)
(progn
  (if
    a
    (progn
      (if
        b
        (princ "A")
        (princ "B"))
      (princ "C")
    )
    (princ "D"))
))

(defun testE (a b)
(progn
  (if
    a
    (if
      b
      (princ "A")
      '())
    (progn
      (if
        b
        (princ "C")
        (princ "D"))
      (princ "E")
    ))
))

(defun test (a b)
(progn
  (testD a b)
  (testE a b)
  (princ "
")
))

(progn
  (test t t)
  (test t nil)
  (test nil t)
  (test nil nil)
)


