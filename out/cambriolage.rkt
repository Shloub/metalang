#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (let ((tab (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    ))))) (list env tab))))
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
                              (let ([max_ancient_pp (max max_ancient_pp (vector-ref pp 0))])
                              (let ([max_recent_pp (max max_recent_pp (vector-ref pp 1))])
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
       ((lambda (internal_env) (apply (lambda (q passepartout) 
                                             (block
                                               q
                                               ((lambda (m) 
                                                  (block
                                                    (mread-blank)
                                                    ((lambda (internal_env) (apply (lambda
                                                     (v serrures) 
                                                    (block
                                                      v
                                                      (display (nbPassePartout n passepartout m serrures))
                                                      )) internal_env)) (array_init_withenv m 
                                                    (lambda (k) 
                                                      (lambda (_) ((lambda (internal_env) (apply (lambda
                                                       (x out1) 
                                                      (block
                                                        x
                                                        (let ([u out1])
                                                        (list '() u))
                                                        )) internal_env)) (array_init_withenv 2 
                                                      (lambda (l) 
                                                        (lambda (_) ((lambda (out_) 
                                                                       (block
                                                                         (mread-blank)
                                                                         (let ([w out_])
                                                                         (list '() w))
                                                                         )) (mread-int)))) '())))) '()))
                                             )) (mread-int))
  )) internal_env)) (array_init_withenv n (lambda (i) 
                                            (lambda (_) ((lambda (internal_env) (apply (lambda
                                             (s out0) 
                                            (block
                                              s
                                              (let ([p out0])
                                              (list '() p))
                                              )) internal_env)) (array_init_withenv 2 
                                            (lambda (j) 
                                              (lambda (_) ((lambda (out01) 
                                                             (block
                                                               (mread-blank)
                                                               (let ([r out01])
                                                               (list '() r))
                                                               )) (mread-int)))) '())))) '()))
)) (mread-int))
)

