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
(define mread-char (lambda ()
  (let ([ out last-char])
    (block
      (next-char)
      out
    ))))

(define main
  (let ([i 1])
  ((lambda (internal_env) (apply (lambda (i last) 
                                        (let ([max0 i])
                                        (let ([index 0])
                                        (let ([nskipdiv 0])
                                        (letrec ([l (lambda (k i index max0 nskipdiv) 
                                                      (if (<= k 995)
                                                      ((lambda (e) 
                                                         (let ([f (- (char->integer e) (char->integer #\0))])
                                                         ((lambda (internal_env) (apply (lambda
                                                          (i nskipdiv) 
                                                         (block
                                                           (vector-set! last index f)
                                                           (let ([index (remainder (+ index 1) 5)])
                                                           (let ([max0 (max max0 i)])
                                                           (l (+ k 1) i index max0 nskipdiv)))
                                                           )) internal_env)) (if (eq? f 0)
                                                                             (let ([i 1])
                                                                             (let ([nskipdiv 4])
                                                                             (list i nskipdiv)))
                                                                             (let ([i (* i f)])
                                                                             (let ([i 
                                                                             (if (< nskipdiv 0)
                                                                             (let ([i (quotient i (vector-ref last index))])
                                                                             i)
                                                                             i)])
                                                                             (let ([nskipdiv (- nskipdiv 1)])
                                                                             (list i nskipdiv)))))))) (mread-char))
                                                      (block
                                                        (map display (list max0 "\n"))
                                                        )))])
                                        (l 1 i index max0 nskipdiv)))))) internal_env)) (array_init_withenv 5 
(lambda (j) 
  (lambda (i) 
    ((lambda (c) 
       (let ([d (- (char->integer c) (char->integer #\0))])
       (let ([i (* i d)])
       (let ([g d])
       (list i g))))) (mread-char)))) i)))
)

