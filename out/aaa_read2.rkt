#lang racket
(require racket/block)

(define main
  (let ([len (string->number (read-line))])
  (block
    (map display (list len "=len\n"))
    (let ([tab (list->vector (map string->number (regexp-split " " (read-line))))])
    (let ([k (- len 1)])
    (letrec ([h (lambda (i) 
                  (if (<= i k)
                  (block
                    (map display (list i "=>" (vector-ref tab i) " "))
                    (h (+ i 1))
                    )
                  (block
                    (display "\n")
                    (let ([tab2 (list->vector (map string->number (regexp-split " " (read-line))))])
                    (let ([g (- len 1)])
                    (letrec ([f (lambda (i_) 
                                  (if (<= i_ g)
                                  (block
                                    (map display (list i_ "==>" (vector-ref tab2 i_) " "))
                                    (f (+ i_ 1))
                                    )
                                  (let ([strlen (string->number (read-line))])
                                  (block
                                    (map display (list strlen "=strlen\n"))
                                    (let ([tab4 (list->vector (string->list (read-line)))])
                                    (let ([e (- strlen 1)])
                                    (letrec ([d (lambda (i3) 
                                                  (if (<= i3 e)
                                                  (let ([tmpc (vector-ref tab4 i3)])
                                                  (let ([c (char->integer tmpc)])
                                                  (block
                                                    (map display (list tmpc ":" c " "))
                                                    (let ([c (if (not (eq? tmpc #\Space))
                                                             (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                                                             c)
                                                             c)])
                                                    (block
                                                      (vector-set! tab4 i3 (integer->char c))
                                                      (d (+ i3 1))
                                                      ))
                                                    )))
                                                  (let ([b (- strlen 1)])
                                                  (letrec ([a (lambda (j) 
                                                                (if (<= j b)
                                                                (block
                                                                  (display (vector-ref tab4 j))
                                                                  (a (+ j 1))
                                                                  )
                                                                '()))])
                                                  (a 0)))))])
                                    (d 0))))
                                  ))))])
                    (f 0))))
      )))])
  (h 0))))
))
)

