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

(define (eratostene t_ max_)
  ;toto
  (let ([sum 0])
  (let ([d 2])
  (let ([e (- max_ 1)])
  (letrec ([a (lambda (i sum) 
                (if (<= i e)
                (let ([sum (if (eq? (vector-ref t_ i) i)
                           (let ([sum (+ sum i)])
                           (let ([j (* i i)])
                           ;
                           ;			detect overflow
                           ;			
                           (let ([j (if (eq? (quotient j i) i)
                                    (letrec ([c (lambda (j) 
                                                  (if (and (< j max_) (> j 0))
                                                  (block
                                                    (vector-set! t_ j 0)
                                                    (let ([j (+ j i)])
                                                    (c j))
                                                    )
                                                  j))])
                                    (c j))
                           j)])
                           sum)))
                sum)])
                (a (+ i 1) sum))
                sum))])
  (a d sum)))))
)
(define main
  (let ([n 100000])
  ; normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 
  (let ([t_ (array_init_withenv n (lambda (i) 
                                    (lambda (_) (let ([f i])
                                                (list '() f)))) '())])
  (block
    (vector-set! t_ 1 0)
    (display (eratostene t_ n))
    (display "\n")
    )))
)

