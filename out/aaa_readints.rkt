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

(define main
  (let ([len (string->number (read-line))])
  (block
    (map display (list len "=len\n"))
    (let ([tab1 (list->vector (map string->number (regexp-split " " (read-line))))])
    (let ([k (- len 1)])
    (letrec ([h (lambda (i) 
                  (if (<= i k)
                  (block
                    (map display (list i "=>" (vector-ref tab1 i) "\n"))
                    (h (+ i 1))
                    )
                  (let ([len (string->number (read-line))])
                  ((lambda (internal_env) (apply (lambda (c tab2) 
                                                        (block
                                                          c
                                                          (let ([g (- len 2)])
                                                          (letrec ([d (lambda (i) 
                                                                        (if (<= i g)
                                                                        (let ([f (- len 1)])
                                                                        (letrec ([e 
                                                                          (lambda (j) 
                                                                            (if (<= j f)
                                                                            (block
                                                                              (map display (list (vector-ref (vector-ref tab2 i) j) " "))
                                                                              (e (+ j 1))
                                                                              )
                                                                            (block
                                                                              (display "\n")
                                                                              (d (+ i 1))
                                                                              )))])
                                                                        (e 0)))
                                                                        '()))])
                                                          (d 0)))
                  )) internal_env)) (array_init_withenv (- len 1) (lambda (a) 
                                                                    (lambda (_) (let ([b (list->vector (map string->number (regexp-split " " (read-line))))])
                                                                                (list '() b)))) '())))))])
  (h 0))))
))
)

