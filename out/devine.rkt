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

(define (devine0 nombre tab len)
  (let ([min0 (vector-ref tab 0)])
  (let ([max0 (vector-ref tab 1)])
  (letrec ([b (lambda (i max0 min0) 
                (if (<= i (- len 1))
                (if (or (> (vector-ref tab i) max0) (< (vector-ref tab i) min0))
                #f
                (let ([min0 (if (< (vector-ref tab i) nombre)
                            (vector-ref tab i)
                            min0)])
                (let ([max0 (if (> (vector-ref tab i) nombre)
                            (vector-ref tab i)
                            max0)])
                (if (and (eq? (vector-ref tab i) nombre) (not (eq? len (+ i 1))))
                #f
                (b (+ i 1) max0 min0)))))
                #t))])
  (b 2 max0 min0))))
)
(define main
  ((lambda (nombre) 
     (block
       (mread-blank)
       ((lambda (len) 
          (block
            (mread-blank)
            (let ([tab (build-vector len (lambda (i) 
                                           ((lambda (tmp) 
                                              (block
                                                (mread-blank)
                                                tmp
                                                )) (mread-int))))])
          (let ([a (devine0 nombre tab len)])
          (if a
          (display "True")
          (display "False"))))
       )) (mread-int))
)) (mread-int))
)

