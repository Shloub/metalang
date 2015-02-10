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

(define (divisible n t0 size)
  ;toto
  (let ([c 0])
  (let ([d (- size 1)])
  (letrec ([b (lambda (i) 
                (if (<= i d)
                (if (eq? (remainder n (vector-ref t0 i)) 0)
                #t
                (b (+ i 1)))
                #f))])
  (b c))))
)
(define (find0 n t0 used nth0)
  ;toto
  (letrec ([a (lambda (n used) 
                (if (not (eq? used nth0))
                ((lambda (internal_env) (apply (lambda (n used) 
                                                      (a n used)) internal_env)) 
                (if (divisible n t0 used)
                (let ([n (+ n 1)])
                (list n used))
                (block
                  (vector-set! t0 used n)
                  (let ([n (+ n 1)])
                  (let ([used (+ used 1)])
                  (list n used)))
                  )))
                (vector-ref t0 (- used 1))))])
  (a n used))
)
(define main
  (let ([n 10001])
  (let ([t0 (array_init_withenv n (lambda (i) 
                                    (lambda (_) (let ([e 2])
                                                (list '() e)))) '())])
  (block
    (map display (list (find0 3 t0 1 n) "\n"))
    )))
)

