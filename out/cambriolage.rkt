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

(define (nbPassePartout n passepartout m serrures)
  (let ([max_ancient 0])
  (let ([max_recent 0])
  (letrec ([d (lambda (i max_ancient max_recent) 
                (if (<= i (- m 1))
                (let ([max_ancient (if (and (eq? (vector-ref (vector-ref serrures i) 0) (- 1)) (> (vector-ref (vector-ref serrures i) 1) max_ancient))
                                   (let ([max_ancient (vector-ref (vector-ref serrures i) 1)])
                                   max_ancient)
                                   max_ancient)])
                (if (and (eq? (vector-ref (vector-ref serrures i) 0) 1) (> (vector-ref (vector-ref serrures i) 1) max_recent))
                (let ([max_recent (vector-ref (vector-ref serrures i) 1)])
                (d (+ i 1) max_ancient max_recent))
                (d (+ i 1) max_ancient max_recent)))
                (let ([max_ancient_pp 0])
                (let ([max_recent_pp 0])
                (letrec ([c (lambda (i max_ancient_pp max_recent_pp) 
                              (if (<= i (- n 1))
                              (let ([pp (vector-ref passepartout i)])
                              (if (and (>= (vector-ref pp 0) max_ancient) (>= (vector-ref pp 1) max_recent))
                              1
                              (let ([max_ancient_pp (max max_ancient_pp (vector-ref pp 0))])
                              (let ([max_recent_pp (max max_recent_pp (vector-ref pp 1))])
                              (c (+ i 1) max_ancient_pp max_recent_pp)))))
                              (if (and (>= max_ancient_pp max_ancient) (>= max_recent_pp max_recent))
                              2
                              0)))])
                (c 0 max_ancient_pp max_recent_pp))))))])
  (d 0 max_ancient max_recent))))
)
(define main
  ((lambda (n) 
     (block
       (mread-blank)
       (let ([passepartout (build-vector n (lambda (i) 
                                             (let ([out0 (build-vector 2 (lambda (j) 
                                                                           ((lambda (out01) 
                                                                              (block
                                                                                (mread-blank)
                                                                                out01
                                                                                )) (mread-int))))])
       out0)))])
  ((lambda (m) 
     (block
       (mread-blank)
       (let ([serrures (build-vector m (lambda (k) 
                                         (let ([out1 (build-vector 2 (lambda (l) 
                                                                       ((lambda (out_) 
                                                                          (block
                                                                            (mread-blank)
                                                                            out_
                                                                            )) (mread-int))))])
       out1)))])
  (display (nbPassePartout n passepartout m serrures)))
)) (mread-int)))
)) (mread-int))
)

