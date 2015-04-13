#lang racket
(require racket/block)
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
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

(define (pathfind_aux cache tab len pos)
  (if (>= pos (- len 1))
  0
  (if (not (eq? (vector-ref cache pos) (- 1)))
  (vector-ref cache pos)
  (block
    (vector-set! cache pos (* len 2))
    (let ([posval (pathfind_aux cache tab len (vector-ref tab pos))])
    (let ([oneval (pathfind_aux cache tab len (+ pos 1))])
    (let ([out0 0])
    (let ([out0 (if (< posval oneval)
                (+ 1 posval)
                (+ 1 oneval))])
    (block
      (vector-set! cache pos out0)
      out0
      )))))
    )))
)
(define (pathfind tab len)
  (let ([cache (build-vector len (lambda (i) 
                                   (- 1)))])
  (pathfind_aux cache tab len 0))
)
(define main
  (let ([len 0])
  ((lambda (a) 
     (let ([len a])
     (block
       (mread-blank)
       (let ([tab (build-vector len (lambda (i) 
                                      (let ([tmp 0])
                                      ((lambda (b) 
                                         (let ([tmp b])
                                         (block
                                           (mread-blank)
                                           tmp
                                           ))) (mread-int)))))])
     (let ([result (pathfind tab len)])
     (display result)))
     ))) (mread-int)))
)

