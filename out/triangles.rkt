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

(define (find0 len tab cache x y)
  ;
  ;	Cette fonction est récursive
  ;	
  (if (eq? y (- len 1))
  (vector-ref (vector-ref tab y) x)
  (if (> x y)
  (- 10000)
  (if (not (eq? (vector-ref (vector-ref cache y) x) 0))
  (vector-ref (vector-ref cache y) x)
  (let ([result 0])
  (let ([out0 (find0 len tab cache x (+ y 1))])
  (let ([out1 (find0 len tab cache (+ x 1) (+ y 1))])
  (let ([result (if (> out0 out1)
                (+ out0 (vector-ref (vector-ref tab y) x))
                (+ out1 (vector-ref (vector-ref tab y) x)))])
  (block
    (vector-set! (vector-ref cache y) x result)
    result
    ))))))))
)
(define (find01 len tab)
  (let ([tab2 (build-vector len (lambda (i) 
                                  (build-vector (+ i 1) (lambda (j) 
                                                          0))))])
(find0 len tab tab2 0 0))
)
(define main
  (let ([len 0])
  ((lambda (a) 
     (let ([len a])
     (block
       (mread-blank)
       (let ([tab (build-vector len (lambda (i) 
                                      (build-vector (+ i 1) (lambda (j) 
                                                              (let ([tmp 0])
                                                              ((lambda (d) 
                                                                 (let ([tmp d])
                                                                 (block
                                                                   (mread-blank)
                                                                   tmp
                                                                   ))) (mread-int)))))))])
     (block
       (printf "~a\n" (find01 len tab))
       (letrec ([b (lambda (k) (if (<= k (- len 1))
                               (letrec ([c (lambda (l) (if (<= l k)
                                                       (block
                                                         (printf "~a " (vector-ref (vector-ref tab k) l))
                                                         (c (+ l 1))
                                                         )
                                                       (block
                                                         (display "\n")
                                                         (b (+ k 1))
                                                         )))])
                                 (c 0))
                               '()))])
         (b 0))
       ))
  ))) (mread-int)))
)

