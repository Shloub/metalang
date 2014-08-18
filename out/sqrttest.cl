
(si::use-fast-links nil)(defun isqrt_ (c)
                         (return-from isqrt_ (isqrt c)))

(progn
  (princ (isqrt_ 4))
  (princ " ")
  (princ (isqrt_ 16))
  (princ " ")
  (princ (isqrt_ 20))
  (princ " ")
  (princ (isqrt_ 1000))
  (princ " ")
  (princ (isqrt_ 500))
  (princ " ")
  (princ (isqrt_ 10))
  (princ " ")
)


