#lang racket
(require racket/block)
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-char (lambda ()
  (let ([ out last-char])
    (block
      (next-char)
      out
    ))))
(define mread-int (lambda ()
  (if (eq? #\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\0)) (<= (char->integer last-char) (char->integer #\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))
(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(define (nth0 tab tofind len)
  (let ([out0 0])
  (letrec ([a (lambda (i out0) 
                (if (<= i (- len 1))
                (if (eq? (vector-ref tab i) tofind)
                (let ([out0 (+ out0 1)])
                (a (+ i 1) out0))
                (a (+ i 1) out0))
                out0))])
  (a 0 out0)))
)
(define main
  (let ([len 0])
  ((lambda (f) 
     (let ([len f])
     (block
       (mread-blank)
       (let ([tofind (integer->char 0)])
       ((lambda (e) 
          (let ([tofind e])
          (block
            (mread-blank)
            (let ([tab (build-vector len (lambda (i) 
                                           (let ([tmp (integer->char 0)])
                                           ((lambda (d) 
                                              (let ([tmp d])
                                              tmp)) (mread-char)))))])
          (let ([result (nth0 tab tofind len)])
          (display result)))
          ))) (mread-char)))
  ))) (mread-int)))
)

