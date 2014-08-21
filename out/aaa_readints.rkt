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

(define (read_int _)
  ;toto
  (string->number (read-line))
)
(define (read_int_line n)
  ;toto
  (list->vector (map string->number (regexp-split " " (read-line))))
)
(define (read_int_matrix x y)
  ;toto
  (let ([tab (array_init_withenv y (lambda (z) 
                                     (lambda (_) (let ([a (read_int_line x)])
                                                 (list '() a)))) '())])
  tab)
)
(define main
  (let ([len (read_int 'nil)])
  (block
    (map display (list len "=len\n"))
    (let ([tab1 (read_int_line len)])
    (let ([k 0])
    (let ([l (- len 1)])
    (letrec ([h (lambda (i) 
                  (if (<= i l)
                  (block
                    (map display (list i "=>" (vector-ref tab1 i) "\n"))
                    (h (+ i 1))
                    )
                  (let ([len (read_int 'nil)])
                  (let ([tab2 (read_int_matrix len (- len 1))])
                  (let ([f 0])
                  (let ([g (- len 2)])
                  (letrec ([b (lambda (i) 
                                (if (<= i g)
                                (let ([d 0])
                                (let ([e (- len 1)])
                                (letrec ([c (lambda (j) 
                                              (if (<= j e)
                                              (block
                                                (map display (list (vector-ref (vector-ref tab2 i) j) " "))
                                                (c (+ j 1))
                                                )
                                              (block
                                                (display "\n")
                                                (b (+ i 1))
                                                )))])
                                (c d))))
                                '()))])
                  (b f))))))))])
    (h k)))))
))
)

