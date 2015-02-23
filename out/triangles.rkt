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

(define (find0 len tab cache x y)
  ;toto
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
                (let ([result (+ out0 (vector-ref (vector-ref tab y) x))])
                result)
                (let ([result (+ out1 (vector-ref (vector-ref tab y) x))])
                result))])
  (block
    (vector-set! (vector-ref cache y) x result)
    result
    ))))))))
)
(define (find01 len tab)
  ;toto
  ((lambda (internal_env) (apply (lambda (b tab2) 
                                        (find0 len tab tab2 0 0)) internal_env)) (array_init_withenv len 
  (lambda (i) 
    (lambda (b) 
      ((lambda (internal_env) (apply (lambda (d tab3) 
                                            (let ([a tab3])
                                            (list '() a))) internal_env)) (array_init_withenv (+ i 1) 
      (lambda (j) 
        (lambda (d) 
          (let ([c 0])
          (list '() c)))) '())))) '()))
)
(define main
  (let ([len 0])
  ((lambda (q) 
     (let ([len q])
     (block
       (mread-blank)
       ((lambda (internal_env) (apply (lambda (f tab) 
                                             (block
                                               (map display (list (find01 len tab) "\n"))
                                               (let ([m (- len 1)])
                                               (letrec ([g (lambda (k) 
                                                             (if (<= k m)
                                                             (letrec ([h (lambda (l) 
                                                                           (if (<= l k)
                                                                           (block
                                                                             (map display (list (vector-ref (vector-ref tab k) l) " "))
                                                                             (h (+ l 1))
                                                                             )
                                                                           (block
                                                                             (display "\n")
                                                                             (g (+ k 1))
                                                                             )))])
                                                             (h 0))
                                                             '()))])
                                               (g 0)))
       )) internal_env)) (array_init_withenv len (lambda (i) 
                                                   (lambda (f) 
                                                     ((lambda (internal_env) (apply (lambda
                                                      (o tab2) 
                                                     (let ([e tab2])
                                                     (list '() e))) internal_env)) (array_init_withenv (+ i 1) 
                                                     (lambda (j) 
                                                       (lambda (o) 
                                                         (let ([tmp 0])
                                                         ((lambda (p) 
                                                            (let ([tmp p])
                                                            (block
                                                              (mread-blank)
                                                              (let ([n tmp])
                                                              (list '() n))
                                                              ))) (mread-int))))) '())))) '()))
))) (mread-int)))
)

