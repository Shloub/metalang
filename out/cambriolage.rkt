#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    )))))
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

(define (max2 a b)
  ;toto
  (max a b)
)
(define (nbPassePartout n passepartout m serrures)
  ;toto
  (let ([max_ancient 0])
  (let ([max_recent 0])
  (let ([h 0])
  (let ([o (- m 1)])
  (letrec ([g (lambda (i max_ancient max_recent) 
                (if (<= i o)
                (let ([max_ancient (if (and (eq? (vector-ref (vector-ref serrures i) 0) (- 1)) (> (vector-ref (vector-ref serrures i) 1) max_ancient))
                                   (let ([max_ancient (vector-ref (vector-ref serrures i) 1)])
                                   max_ancient)
                                   max_ancient)])
                (let ([max_recent (if (and (eq? (vector-ref (vector-ref serrures i) 0) 1) (> (vector-ref (vector-ref serrures i) 1) max_recent))
                                  (let ([max_recent (vector-ref (vector-ref serrures i) 1)])
                                  max_recent)
                                  max_recent)])
                (g (+ i 1) max_ancient max_recent)))
                (let ([max_ancient_pp 0])
                (let ([max_recent_pp 0])
                (let ([e 0])
                (let ([f (- n 1)])
                (letrec ([d (lambda (i max_ancient_pp max_recent_pp) 
                              (if (<= i f)
                              (let ([pp (vector-ref passepartout i)])
                              (if (and (>= (vector-ref pp 0) max_ancient) (>= (vector-ref pp 1) max_recent))
                              1
                              (let ([max_ancient_pp (max2 max_ancient_pp (vector-ref pp 0))])
                              (let ([max_recent_pp (max2 max_recent_pp (vector-ref pp 1))])
                              (d (+ i 1) max_ancient_pp max_recent_pp)))))
                              (let ([c (lambda (_) 
                                         '())])
                              (if (and (>= max_ancient_pp max_ancient) (>= max_recent_pp max_recent))
                              2
                              0))))])
                (d e max_ancient_pp max_recent_pp))))))))])
  (g h max_ancient max_recent))))))
)
(define main
  ((lambda (n) 
     (block
       (mread-blank)
       (let ([passepartout (array_init_withenv n (lambda (i) 
                                                   (lambda (_) (let ([out0 (array_init_withenv 2 
                                                               (lambda (j) 
                                                                 (lambda (_) (
                                                                 (lambda (out__) 
                                                                   (block
                                                                    (mread-blank)
                                                                    (let ([q out__])
                                                                    (list '() q))
                                                                    )) (mread-int)))) '())])
       (let ([p out0])
       (list '() p))))) '())])
  ((lambda (m) 
     (block
       (mread-blank)
       (let ([serrures (array_init_withenv m (lambda (k) 
                                               (lambda (_) (let ([out1 (array_init_withenv 2 
                                                           (lambda (l) 
                                                             (lambda (_) (
                                                             (lambda (out_) 
                                                               (block
                                                                 (mread-blank)
                                                                 (let ([s out_])
                                                                 (list '() s))
                                                                 )) (mread-int)))) '())])
       (let ([r out1])
       (list '() r))))) '())])
  (display (nbPassePartout n passepartout m serrures)))
)) (mread-int)))
)) (mread-int))
)

